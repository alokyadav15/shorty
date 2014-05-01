class CreateShorts < ActiveRecord::Migration
  def change
    create_table :shorts do |t|
      t.string :full
      t.string :short
      t.string :slug

      t.timestamps
    end
  end
end
