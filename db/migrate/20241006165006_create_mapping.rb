class CreateMapping < ActiveRecord::Migration[7.2]
  def change
    create_table "ctgov_api.mappings" do |t|
      t.string :table_name
      t.string :field_name
      t.boolean :active, default: true
      t.string :api_path
      t.references :ctgov_api_metadata,
                  foreign_key: { to_table: 'ctgov_api.metadata' },
                  null: true
      t.timestamps
    end
  end
end
