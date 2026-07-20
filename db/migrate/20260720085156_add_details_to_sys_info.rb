class AddDetailsToSysInfo < ActiveRecord::Migration[8.1]
  def change
    add_column :sys_infos, :system_model, :string
    add_column :sys_infos, :max_memory, :string
    add_column :sys_infos, :logical_cpu, :string
  end
end
