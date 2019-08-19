class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :url
      t.float :price
      t.integer :delivery_in_days
    end
  end
end