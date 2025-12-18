package main

import (
	"log"
	"time"
	"wallet-api/config"
	"wallet-api/controllers"
	"wallet-api/middlewares"
	"wallet-api/models"

	"github.com/gin-gonic/gin"
)

func processTransferQueue() {
	var queues []models.TransferQueue
	config.DB.Where("status = ?", "PENDING").Find(&queues)

	for _, q := range queues {
		// Validasi ID
		if q.FromUserID == "" || q.ToUserID == "" {
			log.Println("Invalid transfer queue, marking as FAILED:", q.TransferQueueID)
			now := time.Now()
			q.Status = "FAILED"
			q.ProcessedAt = &now
			config.DB.Save(&q)
			continue
		}

		var fromUser, toUser models.User
		if err := config.DB.First(&fromUser, "user_id = ?", q.FromUserID).Error; err != nil {
			log.Println("FromUser not found, marking as FAILED:", q.TransferQueueID)
			now := time.Now()
			q.Status = "FAILED"
			q.ProcessedAt = &now
			config.DB.Save(&q)
			continue
		}

		if err := config.DB.First(&toUser, "user_id = ?", q.ToUserID).Error; err != nil {
			log.Println("ToUser not found, marking as FAILED:", q.TransferQueueID)
			now := time.Now()
			q.Status = "FAILED"
			q.ProcessedAt = &now
			config.DB.Save(&q)
			continue
		}

		if fromUser.Balance < q.Amount {
			log.Println("Insufficient balance, marking as FAILED:", q.TransferQueueID)
			now := time.Now()
			q.Status = "FAILED"
			q.ProcessedAt = &now
			config.DB.Save(&q)
			continue
		}

		balanceBefore := fromUser.Balance
		fromUser.Balance -= q.Amount
		toUser.Balance += q.Amount

		config.DB.Save(&fromUser)
		config.DB.Save(&toUser)

		now := time.Now()
		q.Status = "COMPLETED"
		q.ProcessedAt = &now
		config.DB.Save(&q)

		config.DB.Create(&models.Transaction{
			UserID:        fromUser.UserID,
			Type:          "DEBIT",
			Amount:        q.Amount,
			Remarks:       q.Remarks,
			BalanceBefore: balanceBefore,
			BalanceAfter:  fromUser.Balance,
			CreatedAt:     now,
		})
		config.DB.Create(&models.Transaction{
			UserID:        toUser.UserID,
			Type:          "CREDIT",
			Amount:        q.Amount,
			Remarks:       q.Remarks,
			BalanceBefore: toUser.Balance - q.Amount,
			BalanceAfter:  toUser.Balance,
			CreatedAt:     now,
		})

		log.Println("Transfer completed:", q.TransferQueueID)
	}
}

func main() {
	config.ConnectDatabase()

	go func() {
		for {
			processTransferQueue()
			time.Sleep(5 * time.Second)
		}
	}()

	r := gin.Default()

	r.POST("/register", controllers.Register)
	r.POST("/login", controllers.Login)

	auth := r.Group("/", middlewares.AuthMiddleware())
	auth.POST("/topup", controllers.TopUp)
	auth.POST("/pay", controllers.Payment)
	auth.POST("/transfer", controllers.Transfer)
	auth.GET("/transactions", controllers.TransactionReport)
	auth.PUT("/profile", controllers.UpdateProfile)

	log.Println("Server running on :8000")
	r.Run(":8000")
}
