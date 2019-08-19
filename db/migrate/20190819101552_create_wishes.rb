class CreateWishes < ActiveRecord::Migration[5.2]
  def change
    create_table :wishes do |t|
      t.integer :quantity
      t.string :occasion
      t.integer :user_id
      t.integer :product_id
    end
  end
end
