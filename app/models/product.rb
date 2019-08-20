class Product < ActiveRecord::Base
    has_many :wishes
    has_many :users, through: :wishes

    def product_name_and_price
        "#{name}, £#{price}"
    end

end