class MessagesController < ApplicationController
    before_action :authorize_request
  
    def index
      messages = Message.where('sender_id = ? OR receiver_id = ?', @current_user.id, @current_user.id)
      render json: messages
    end
  
    def create
      message = Message.new(message_params.merge(sender_id: @current_user.id))
      if message.save
        render json: message, status: :created
      else
        render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def message_params
      params.permit(:receiver_id, :content)
    end
  end
  