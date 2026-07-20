class CreateSysInfos < ActiveRecord::Migration[8.1]
  def change
    create_table :sys_infos do |t|
      t.string :name

      t.timestamps
    end
  end
end
