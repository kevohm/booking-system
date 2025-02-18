class UserController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "Welcome, #{@user.email_address}!"
    else
      redirect_to new_session_path, warn: "Account creation failed"
    end
  end

  private

  def user_params
    params.permit(:email_address, :password, :password_confirmation, :role)
  end
end
