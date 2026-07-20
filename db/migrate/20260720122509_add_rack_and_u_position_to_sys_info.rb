class AddRackAndUPositionToSysInfo < ActiveRecord::Migration[8.1]
  def change
    add_column :sys_infos, :rack, :string
    add_column :sys_infos, :u_position, :string
  end
end
