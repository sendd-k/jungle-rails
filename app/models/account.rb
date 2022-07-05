class Account < ActiveRecord::Base
  has_secure_password

  validates_uniqueness_of :email, case_sensitive: false, presence: true
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.authenticate_with_credentials(email, password)
    account = Account.find_by_email(email.downcase.strip)
    if account && account.authenticate(password)
      account
    else
      nil
    end
  end
end