# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new
    session[:need_register] ||= false
  end

  def create
    if @user&.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      session[:need_register] = false
    else
      session[:need_register] = true
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def find_user
    @user = User.find_by(email: params[:session][:email])
  end
end
