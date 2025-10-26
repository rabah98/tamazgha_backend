class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        token = encode_token({ user_id: user.id })
        render json: { user: user, token: token }
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    def destroy
      # Token-based logout is handled on frontend by removing token
      render json: { message: 'Logged out' }
    end
  end
  