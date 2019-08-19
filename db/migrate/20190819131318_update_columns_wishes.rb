class UpdateColumnsWishes < ActiveRecord::Migration[5.2]
  def change
    add_column :wishes, :created_on, :datetime
  end
end
