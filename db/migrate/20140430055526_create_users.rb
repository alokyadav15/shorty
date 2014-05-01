class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :token_counts

      t.timestamps
    end
  end
end
