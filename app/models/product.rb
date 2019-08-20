class Product < ActiveRecord::Base
    has_many :wishes
    has_many :users, through: :wishes

    validates :name, presence: true
    validates :url, presence: true
    validates :price, presence: true


    def product_name_and_price
        "#{name}, £#{price}"
    end

end