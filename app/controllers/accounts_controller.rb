class AccountsController < ApplicationController
  def new
  end

  def create
    account = Account.new(account_params)
    if account.save
      session[:account_id] = account.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private

  def account_params
    params.require(:account).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end
end
