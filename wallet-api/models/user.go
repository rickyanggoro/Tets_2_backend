package models

import (
    "time"

    "github.com/google/uuid"
    "gorm.io/gorm"
)

type User struct {
    UserID    string `gorm:"primaryKey;type:varchar(36)"`
    FirstName string `gorm:"type:varchar(100)"`
    LastName  string `gorm:"type:varchar(100)"`
    Phone     string `gorm:"uniqueIndex;type:varchar(20)"`
    PIN       string `gorm:"type:varchar(10)"`
    Address   string `gorm:"type:text"`
    Balance   int64
    CreatedAt time.Time
    UpdatedAt time.Time
}

// Hook BeforeCreate untuk otomatis set UserID
func (u *User) BeforeCreate(tx *gorm.DB) (err error) {
    u.UserID = uuid.New().String()
    u.CreatedAt = time.Now()
    u.UpdatedAt = time.Now()
    return
}
