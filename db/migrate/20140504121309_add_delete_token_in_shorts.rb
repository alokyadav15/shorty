class AddDeleteTokenInShorts < ActiveRecord::Migration
  def change
  	add_column :shorts, :delete_token, :string
  end
end
