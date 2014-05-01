class AddTokensToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_token, :string
  end
end
