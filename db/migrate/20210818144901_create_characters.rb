class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :class
      t.string :species
      t.integer :level
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
