class User < ApplicationRecord
    has_secure_password
  
    has_many :listings
    has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
    has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
  
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
  end
  