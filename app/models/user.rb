class User < ApplicationRecord
  has_secure_password validations: false
  has_many :sessions, dependent: :destroy

  validates :email, presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }
  validates :password, on: [ :registration, :password_change ],
            presence: true,
            length: { minimum: 8, maximum: 72 }
  validates_with Validators::PasswordMaxLength, fields: [ :password ], on: [ :registration, :password_change ]
  validates_presence_of :password_confirmation, on: [ :password_change ]
  validates_confirmation_of :password, on: [ :password_change ]

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
