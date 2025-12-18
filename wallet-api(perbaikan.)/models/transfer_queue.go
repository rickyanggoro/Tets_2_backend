package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type TransferQueue struct {
	TransferQueueID string     `gorm:"type:varchar(36);primaryKey;column:transfer_queue_id"`
	FromUserID      string     `gorm:"type:varchar(36);column:from_user_id"`
	ToUserID        string     `gorm:"type:varchar(36);column:to_user_id"`
	Amount          int64      `gorm:"type:bigint"`
	Remarks         string     `gorm:"type:varchar(255)"`
	Status          string     `gorm:"type:varchar(20)"`
	CreatedAt       time.Time  `gorm:"column:created_at"`
	ProcessedAt     *time.Time `gorm:"column:processed_at"`
}

func (t *TransferQueue) BeforeCreate(tx *gorm.DB) (err error) {
	t.TransferQueueID = uuid.New().String()
	t.Status = "PENDING"
	t.CreatedAt = time.Now()
	return
}
