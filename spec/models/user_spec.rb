require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "Validations" do
    
    it "is invalid if no first name" do
      account = Account.new(firstname: nil, lastname: "Holmes", email: "kevin@holmes.com", password: "password", password_confirmation: "password")
      account.save
      expect(account.errors.full_messages).to include "Firstname can't be blank"
    end

    it "is invalid if no last name" do
      account = Account.new(firstname: "Kevin", lastname: nil, email: "kevin@holmes.com", password: "password", password_confirmation: "password")
      account.save
      expect(account.errors.full_messages).to include "Lastname can't be blank"
    end

    it "is invalid if no password" do
      account = Account.new(firstname: "Kevin", lastname: "Holmes", email: "kevin@holmes.com", password: nil, password_confirmation: "password")
      account.save
      expect(account.errors.full_messages).to include "Password can't be blank"
    end

    it "is invalid if passords don't match" do
      account = Account.new(firstname: "Kevin", lastname: "Holmes", email: "kevin@holmes.com", password: "password", password_confirmation: "password123")
      account.save
      expect(account.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it "is invalid if email is not unique" do
      account_one = Account.new(firstname: "Kevin", lastname: "Holmes", email: "kevin@holmes.com", password: "password", password_confirmation: "password")
      account_one.save
      account_two = Account.new(firstname: "Kevin", lastname: "Holmes", email: "kevin@holmes.com", password: "password", password_confirmation: "password")
      account_two.save
      expect(account_two.errors.full_messages).to include "Email has already been taken"
    end

    it "is invalid without proper email" do
      account = Account.new(firstname: "Kevin", lastname: "Holmes", email: "invalid.com", password: "password", password_confirmation: "password")
      account.save
      expect(account.errors.full_messages).to include "Email is invalid"
    end

    it "is invalid if password is < 3 characters" do
      account = Account.new(firstname: "Kevin", lastname: "Holmes", email: "kevin@holmes.com", password: "12", password_confirmation: "12")
      account.save
      expect(account.errors.full_messages).to include "Password is too short (minimum is 3 characters)"
    end
  end

  describe " .authenticate_with_credentials" do
    it "valids account with credentails" do
      account = Account.new(firstname: "Kevin", lastname: "Holmes", email: "kevin@holmes.com", password: "password", password_confirmation: "password")
      account.save

      expect(Account.authenticate_with_credentials("kevin@wrong.com", "1234")).to eql nil
    end

    it "valids account with credentails with whitespace and caps" do
      account = Account.new(firstname: "Kevin", lastname: "Holmes", email: "kevin@holmes.com", password: "password", password_confirmation: "password")
      account.save

      expect(Account.authenticate_with_credentials(" Kevin@Holmes.com ", "password")).to eql account
    end
  end
end
