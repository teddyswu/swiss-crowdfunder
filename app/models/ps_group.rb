class PsGroup < AgricDbConnecter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  self.table_name = "ps_groups"
  self.primary_key = "id"

  has_many :farmer_profiles

  scope :normal_state, -> { where(enabled: true) }

end
