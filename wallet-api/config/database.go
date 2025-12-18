package config

import (
    "log"
    "wallet-api/models"

    "gorm.io/driver/mysql"
    "gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDatabase() {
    dsn := "root:@tcp(127.0.0.1:3306)/wallet_db?charset=utf8mb4&parseTime=True&loc=Local"

    database, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
    if err != nil {
        log.Fatal("Failed connect database")
    }

    DB = database

    // AUTO MIGRATION (INI PENTING)
    DB.AutoMigrate(
        &models.User{},
        &models.Transaction{},
        &models.TransferQueue{},
    )
}
