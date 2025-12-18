package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type User struct {
	UserID    string `gorm:"type:varchar(36);primaryKey;column:user_id"`
	FirstName string
	LastName  string
	Phone     string `gorm:"unique"`
	PIN       string
	Address   string
	Balance   int64
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (u *User) BeforeCreate(tx *gorm.DB) (err error) {
	u.UserID = uuid.New().String()
	u.CreatedAt = time.Now()
	u.UpdatedAt = time.Now()
	return
}
