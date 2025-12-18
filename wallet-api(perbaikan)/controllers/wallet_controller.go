package controllers

import (
	"net/http"
	"time"

	"wallet-api/config"
	"wallet-api/models"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v4"
)

var jwtKey = []byte("SECRET_KEY")

func Register(c *gin.Context) {
	var input struct {
		FirstName string `json:"first_name" binding:"required"`
		LastName  string `json:"last_name" binding:"required"`
		Phone     string `json:"phone" binding:"required"`
		Address   string `json:"address"`
		PIN       string `json:"pin" binding:"required"`
	}

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	var exist models.User
	if err := config.DB.Where("phone = ?", input.Phone).First(&exist).Error; err == nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Phone Number already registered"})
		return
	}

	user := models.User{
		FirstName: input.FirstName,
		LastName:  input.LastName,
		Phone:     input.Phone,
		PIN:       input.PIN,
		Address:   input.Address,
		Balance:   0,
	}

	if err := config.DB.Create(&user).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"status": "SUCCESS",
		"result": user,
	})
}

func Login(c *gin.Context) {
	var input struct {
		Phone string `json:"phone"`
		PIN   string `json:"pin"`
	}

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	var user models.User
	if err := config.DB.Where("phone = ? AND pin = ?", input.Phone, input.PIN).
		First(&user).Error; err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "Phone Number and PIN doesn't match"})
		return
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"user_id": user.UserID,
		"exp":     time.Now().Add(time.Hour).Unix(),
	})

	tokenStr, _ := token.SignedString(jwtKey)

	c.JSON(http.StatusOK, gin.H{
		"status": "SUCCESS",
		"result": gin.H{
			"access_token":  tokenStr,
			"refresh_token": tokenStr,
		},
	})
}

func TopUp(c *gin.Context) {
	userID := c.MustGet("user_id").(string)

	var input struct {
		Amount int64 `json:"amount"`
	}

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	var user models.User
	config.DB.First(&user, "user_id = ?", userID)

	balanceBefore := user.Balance
	balanceAfter := balanceBefore + input.Amount

	config.DB.Model(&user).Update("balance", balanceAfter)

	trx := models.Transaction{
		UserID:        userID,
		Type:          "CREDIT",
		Amount:        input.Amount,
		BalanceBefore: balanceBefore,
		BalanceAfter:  balanceAfter,
		Remarks:       "Top Up",
		CreatedAt:     time.Now(),
	}

	config.DB.Create(&trx)

	c.JSON(http.StatusOK, gin.H{
		"status": "SUCCESS",
		"result": trx,
	})
}

func Payment(c *gin.Context) {
	userID := c.MustGet("user_id").(string)

	var input struct {
		Amount  int64  `json:"amount"`
		Remarks string `json:"remarks"`
	}

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	var user models.User
	config.DB.First(&user, "user_id = ?", userID)

	if user.Balance < input.Amount {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Balance is not enough"})
		return
	}

	balanceBefore := user.Balance
	balanceAfter := balanceBefore - input.Amount

	config.DB.Model(&user).Update("balance", balanceAfter)

	trx := models.Transaction{
		UserID:        userID,
		Type:          "DEBIT",
		Amount:        input.Amount,
		Remarks:       input.Remarks,
		BalanceBefore: balanceBefore,
		BalanceAfter:  balanceAfter,
		CreatedAt:     time.Now(),
	}

	config.DB.Create(&trx)

	c.JSON(http.StatusOK, gin.H{
		"status": "SUCCESS",
		"result": trx,
	})
}

func Transfer(c *gin.Context) {
	userID := c.MustGet("user_id").(string)

	var input struct {
		TargetUser string `json:"target_user" binding:"required"`
		Amount     int64  `json:"amount" binding:"required"`
		Remarks    string `json:"remarks"`
	}

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	var fromUser models.User
	if err := config.DB.First(&fromUser, "user_id = ?", userID).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Sender not found"})
		return
	}

	if fromUser.Balance < input.Amount {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Balance is not enough"})
		return
	}

	var toUser models.User
	if err := config.DB.First(&toUser, "user_id = ?", input.TargetUser).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Target user not found"})
		return
	}

	fromUser.Balance -= input.Amount
	if err := config.DB.Save(&fromUser).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to update sender balance"})
		return
	}

	queue := models.TransferQueue{
		FromUserID: userID,
		ToUserID:   input.TargetUser,
		Amount:     input.Amount,
		Remarks:    input.Remarks,
		Status:     "PENDING",
		CreatedAt:  time.Now(),
	}

	if err := config.DB.Create(&queue).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to create transfer queue"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"status": "SUCCESS",
		"result": queue,
	})
}

func TransactionReport(c *gin.Context) {
	userID := c.MustGet("user_id").(string)

	var trx []models.Transaction
	config.DB.Where("user_id = ?", userID).
		Order("created_at desc").
		Find(&trx)

	c.JSON(http.StatusOK, gin.H{
		"status": "SUCCESS",
		"result": trx,
	})
}

func UpdateProfile(c *gin.Context) {
	userID := c.MustGet("user_id").(string)

	var input struct {
		FirstName string `json:"first_name"`
		LastName  string `json:"last_name"`
		Address   string `json:"address"`
	}

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": err.Error()})
		return
	}

	var user models.User
	config.DB.First(&user, "user_id = ?", userID)

	user.FirstName = input.FirstName
	user.LastName = input.LastName
	user.Address = input.Address
	user.UpdatedAt = time.Now()

	config.DB.Save(&user)

	c.JSON(http.StatusOK, gin.H{
		"status": "SUCCESS",
		"result": user,
	})
}
