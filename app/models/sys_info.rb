class SysInfo < ApplicationRecord
  has_many :imported_jsons, dependent: :destroy

end
