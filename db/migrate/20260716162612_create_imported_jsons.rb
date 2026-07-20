class CreateImportedJsons < ActiveRecord::Migration[8.1]
  def change
    create_table :imported_jsons do |t|
      t.text :raw_json
      t.references :sys_info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
