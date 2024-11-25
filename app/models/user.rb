class User < ApplicationRecord
  has_secure_password validations: false
  has_many :sessions, dependent: :destroy
  has_many :omni_auth_identities, dependent: :destroy
  has_many :request_logs, dependent: :nullify

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

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.create_from_oauth(auth)
    email = auth.info.email
    user = self.new email: email
    assign_names_from_auth(auth, user)
    user.save
    user
  end

  def signed_in_with_oauth(auth)
    User.assign_names_from_auth(auth, self)
    save if first_name_changed? || last_name_changed?
  end

  private

  def self.assign_names_from_auth(auth, user)
    provider = auth["provider"]
    case provider
    when "developer"
      if user.first_name.blank? && user.last_name.blank?
        user.first_name = auth.info.name
        user.last_name = "Developer"
      end
    when "google_oauth2"
      if user.first_name.blank? && user.last_name.blank?
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
      end
    when "github"
      if user.first_name.blank? && user.last_name.blank?
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
      end
    end
  end
end
