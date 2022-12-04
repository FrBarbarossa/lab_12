class AuthController < ApplicationController
    before_action :not_authed_yet, only: [:register, :login]
    # Вопрос к безопасности такого действия
    skip_before_action :verify_authenticity_token

    def register
      respond_to do |format|
        format.html
        format.turbo_stream {
          @user = User.new(register_params)
          if @user.valid?
            @user.save
            session[:current_user_id] = @user.id
            redirect_to '/'
          end
          }
      end
    end

    def login
      respond_to do |format|
        format.html
        format.turbo_stream{
          @user = User.find_by(login: login_params[:login])
          p @user
          # p User.all
          if @user
            if @user.authenticate(login_params[:password])
              reset_session
              session[:current_user_id] = @user.id
              redirect_to '/'
            end
          end
        }
      end
    end

    def logout
      session.delete(:current_user_id)
      redirect_to '/', alert: "Вы успешно вышли из системы"
    end

    # Can be delited in current configuration
    def reguser
      @user = User.new(register_params)
      if @user.valid?
        @user.save
        session[:current_user_id] = @user.id
        redirect_to '/'
      end
    end    
    
    # Can be delited in current configuration
    def loguser
      # p login_params
      @user = User.find_by(login: login_params[:login])
      p @user
      # p User.all
      reset_session
      if @user
        if @user.authenticate(login_params[:password])
          session[:current_user_id] = @user.id
          redirect_to '/'
        end
      end
    end

    def showuser
      @user = User.all.select(:id, :login)
      p @user
    end

    private

    def register_params
      params.permit(:login, :password, :password_confirmation) # явно задаем, какие параметры разрешены
    end
    
    def login_params
      params.permit(:login, :password)
    end
end
