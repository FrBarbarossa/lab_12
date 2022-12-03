class AuthController < ApplicationController
    # skip_before_action :check_auth, only: [:register, :login]
    before_action :not_authed_yet, only: [:register, :login]

    def register
    end

    def login
    end

    def logout
      session.delete(:current_user_id)
      redirect_to '/', alert: "Вы успешно вышли из системы"
    end

    def reguser
      @user = User.new(register_params)
      if @user.valid?
        @user.save
        session[:current_user_id] = @user.id
        redirect_to '/'
      end
    end    
    
    def loguser
      p login_params
      @user = User.find_by(login: login_params[:login])
      p @user
      if @user
        if @user.authenticate(login_params[:password])
          session[:current_user_id] = @user.id
          redirect_to '/'
        end
      end
    end

    private

    def register_params
      params.permit(:login, :password, :password_confirmation) # явно задаем, какие параметры разрешены
    end
    
    def login_params
      params.permit(:login, :password)
    end
end
