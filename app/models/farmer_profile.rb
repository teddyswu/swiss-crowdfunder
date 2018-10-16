class FarmerProfile < AgricDbConnecter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  self.table_name = "farmer_profiles"
  self.primary_key = "id"
  belongs_to :user
end
