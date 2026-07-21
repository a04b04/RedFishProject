class AddNotesToSysInfo < ActiveRecord::Migration[8.1]
  def change
    add_column :sys_infos, :notes, :text
  end
end
