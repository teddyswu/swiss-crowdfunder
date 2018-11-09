class Authorization < AgricDbConnecter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  self.table_name = "authorizations"
  self.primary_key = "id"

  belongs_to :user

end
