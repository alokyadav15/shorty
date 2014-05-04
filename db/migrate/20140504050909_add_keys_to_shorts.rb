class AddKeysToShorts < ActiveRecord::Migration
  def change
    add_column :shorts, :encrypted_url, :text
    add_column :shorts, :key, :text
  end
end
