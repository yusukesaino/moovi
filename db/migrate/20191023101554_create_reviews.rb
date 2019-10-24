class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

      t.timestamps
      t.string :nickname
      t.integer :rate
      t.text :review
      t.integer :product_id
    end
  end
end
