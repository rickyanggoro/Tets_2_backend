package models

import (
    "time"
    "github.com/google/uuid"
    "gorm.io/gorm"
)

type Transaction struct {
    TransactionID string    `gorm:"primaryKey;type:varchar(36)"`
    UserID        string
    Type          string    
    Amount        int64
    Remarks       string
    BalanceBefore int64
    BalanceAfter  int64
    CreatedAt     time.Time
}

func (t *Transaction) BeforeCreate(tx *gorm.DB) (err error) {
    t.TransactionID = uuid.New().String()
    t.CreatedAt = time.Now()
    return
}
