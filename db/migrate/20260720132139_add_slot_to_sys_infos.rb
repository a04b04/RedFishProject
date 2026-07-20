class AddSlotToSysInfos < ActiveRecord::Migration[8.1]
  def change
    add_column :sys_infos, :slot, :string
  end
end
