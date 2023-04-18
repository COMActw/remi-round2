# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout 'application'

  helper_method :current_user, :need_register?, :videos_list

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def videos_list
    @videos_list = Video.all
  end

  def need_register?
    @need_register = session[:need_register]
  end
end
