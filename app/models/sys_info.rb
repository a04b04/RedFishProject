class SysInfo < ApplicationRecord
  has_many :imported_jsons, dependent: :destroy


  def previous_server
    SysInfo
    .where("created_at < ?", created_at)
    .order(created_at: :desc)
    .first
  end

  def next_server
    SysInfo
    .where("created_at > ?", created_at)
    .order(created_at: :asc)
    .first
  end

end
