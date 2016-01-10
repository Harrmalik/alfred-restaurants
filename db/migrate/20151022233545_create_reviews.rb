class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :quality
      t.integer :price
      t.integer :environment
      t.integer :rating

      t.timestamps null: false
    end
  end
end
