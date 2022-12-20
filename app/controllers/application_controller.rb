# frozen_string_literal: true

# Check
class ApplicationController < ActionController::Base
  # before_action :check_auth

  def check_auth
    # session[:current_user_id] = 11
    redirect_to '/', alert: 'Вы должны войти в систему для просмотра содержимого' unless session[:current_user_id]
    return unless session[:current_user_id]

    reset_session if session[:last_seen] < 1.minutes.ago
    session[:last_seen] = Time.now
  end

  def not_authed_yet
    redirect_to '/', alert: 'Вы уже в системе' if session[:current_user_id]
  end

  def authenticate
    session[:last_seen] = Time.now
  end
end
