class AUserProfile < AgricDbConnecter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  self.table_name = "user_profiles"
  self.primary_key = "id"
  belongs_to :user
end
