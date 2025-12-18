package routes

import (
    "github.com/gin-gonic/gin"
    "wallet-api/controllers"
    "wallet-api/middlewares"
)

func SetupRouter() *gin.Engine {
    r := gin.Default()

    r.POST("/register", controllers.Register)
    r.POST("/login", controllers.Login)

    auth := r.Group("/", middlewares.AuthMiddleware())
    auth.POST("/topup", controllers.TopUp)
    auth.POST("/pay", controllers.Payment)
    auth.POST("/transfer", controllers.Transfer)
    auth.GET("/transactions", controllers.TransactionReport)
    auth.PUT("/profile", controllers.UpdateProfile)

    return r
}
