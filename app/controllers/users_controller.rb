# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)

    respond_to do |format|
      if @user&.save
        format.html { redirect_to root_path }
      else
        session[:need_register] = true unless @user.save
        format.html { render 'videos/index', status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_create_params
    return unless user_params[:password].equal?(user_params[:password_confirmation])

    @user_create_params = {
      email: user_params[:email],
      password: user_params[:password]
    }
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
