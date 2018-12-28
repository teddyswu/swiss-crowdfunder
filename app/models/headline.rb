class Headline < AgricDbConnecter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  self.table_name = "headlines"
  self.primary_key = "id"
end