class User < AgricDbConnecter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  self.table_name = "users"
  self.primary_key = "id"
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :registerable
  has_many :campaign_replies
  has_many :campaign_groups
  has_many :campaigns
  has_many :tracks
  has_many :orders
  has_one :user_profile
  has_one :farmer_profile

end
