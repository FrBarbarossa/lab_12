class PalindromesController < ApplicationController
    # before_action :check_num, only: :result
    before_action :check_auth, only: :result
  
    def index
    end
  
    def result
      @new_result = Result.find_by(input: params[:number])
      return unless @new_result.nil?
      @new_result = Result.new(input: params[:number])
      if @new_result.valid?
        @new_result.save
      else
        redirect_to '/', alert: @new_result.errors['expiration_date'][0]
      end
    
    end

    def show
      render xml: Result.all.to_xml
    end

  end