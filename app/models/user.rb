class User < AgricDbConnecter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  self.table_name = "users"
  self.primary_key = "id"
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :registerable, :omniauthable, :confirmable
  has_many :campaign_replies
  has_many :campaign_groups
  has_many :campaigns
  has_many :tracks
  has_many :orders
  has_many :favo_farmers
  has_many :favo_farmers, :foreign_key => "farmer_id"
  has_many :authorizations
  has_one :user_profile
  has_one :farmer_profile
  
  extend OmniauthCallbacks

end
