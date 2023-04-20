# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :find_user, only: :create
  before_action :validate_exist, only: :create


  def new
    session[:need_register] = false
  end

  def create
    return unless validate_exist

    if @user&.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      session[:need_register] = false
      redirect_to root_path, flash: { success: 'Login success' }
    else
      session[:need_register] = false
      redirect_to root_path, flash: { danger: 'Invalid email or password' }
    end
  end

  def validate_exist
    unless find_user
      session[:need_register] = false
      redirect_to root_path, flash: { danger: 'User not exist' }
      false
    end
    true
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def find_user
    @user = User.find_by(email: params[:session][:email])
  end
end
