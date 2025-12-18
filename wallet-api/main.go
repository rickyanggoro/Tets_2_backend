package main

import (
    "log"
    "time"
    "wallet-api/config"
    "wallet-api/controllers"
    "wallet-api/models"
    "wallet-api/middlewares"

    "github.com/gin-gonic/gin"
)

func processTransferQueue() {
    var queues []models.TransferQueue
    config.DB.Where("status = ?", "PENDING").Find(&queues)

    for _, q := range queues {
        var fromUser, toUser models.User
        config.DB.First(&fromUser, "user_id = ?", q.FromUserID)
        config.DB.First(&toUser, "user_id = ?", q.ToUserID)

        if fromUser.Balance < q.Amount {
            log.Println("Insufficient balance for transfer:", q.TransferQueueID)
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

    r.Run(":8000")
}
