class UsersController < ApplicationController
    before_action :authorize_request, only: [:dashboard]
    before_action :set_user, only: [:destroy]
  
    def create
      user = User.new(user_params)
      if user.save
        token = encode_token({ user_id: user.id })
        render json: { user: user, token: token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def dashboard
      user = @current_user
      render json: { user: user, listings: user.listings, messages: user.received_messages }
    end

    def destroy
      if @user.destroy
        render json: { message: "User deleted successfully" }
      else
        render json: { error: "Failed to delete user" }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    end    

    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end
  