package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type TransferQueue struct {
	TransferQueueID string
	FromUserID      string
	ToUserID        string
	Amount          int64
	Remarks         string
	Status          string
	CreatedAt       time.Time
	ProcessedAt     *time.Time
}

func (t *TransferQueue) BeforeCreate(tx *gorm.DB) (err error) {
	t.TransferQueueID = uuid.New().String()
	t.Status = "PENDING"
	t.CreatedAt = time.Now()
	return
}
