class CreateCtgovApiSchema < ActiveRecord::Migration[7.2]
  def change
    execute "CREATE SCHEMA IF NOT EXISTS ctgov_api"
  end
end
