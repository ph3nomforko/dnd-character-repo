class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :build
      t.string :species
      t.integer :level
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
