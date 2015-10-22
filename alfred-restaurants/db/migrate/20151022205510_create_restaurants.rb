class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.integer :quality
      t.integer :price
      t.integer :environment
      t.integer :overall

      t.timestamps null: false
    end
  end
end
