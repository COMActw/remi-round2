# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout 'application'

  helper_method :current_user, :need_register?, :videos_list
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Exception, with: :error
  rescue_from ActionController::RoutingError, with: :not_found

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

  def raise_not_found
    raise ActionController::RoutingError, "No route matches #{params[:unmatched_route]}"
  end

  def not_found
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  def error
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/500.html", layout: false, status: 500 }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end
end
