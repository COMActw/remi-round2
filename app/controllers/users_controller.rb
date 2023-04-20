# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :validate_match, only: :create
  before_action :validate_exist, only: :create

  def new
    @user = User.new
  end

  def create
    return unless validate_match
    return unless validate_exist

    @user = User.new(user_create_params)

    if @user&.save
      session[:need_register] = false
      redirect_to root_path, flash: { success: 'Resgister success' }
    else
      session[:need_register] = true
      redirect_to root_path, flash: { danger: 'Invalid email or password' }
    end
  end

  def validate_match
    unless user_params[:password].match?(user_params[:password_confirmation])
      session[:need_register] = true
      redirect_to root_path, flash: { danger: 'Confirmation password not match' }

      false
    end
    true
  end

  def validate_exist
    if User.find_by(email: user_params[:email])
      session[:need_register] = true
      redirect_to root_path, flash: { danger: 'User already exist' }
      false
    end
    true
  end

  private

  def user_create_params
    return unless user_params[:password].match?(user_params[:password_confirmation])

    @user_create_params = {
      email: user_params[:email],
      password: user_params[:password]
    }
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
