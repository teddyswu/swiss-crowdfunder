class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :registerable
  has_many :campaign_replies
  has_many :campaigns
  has_many :tracks
  has_many :orders
  has_one :user_profile

end
