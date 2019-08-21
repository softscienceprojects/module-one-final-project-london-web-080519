class Product < ActiveRecord::Base
    has_many :wishes
    has_many :users, through: :wishes

    validates :name, presence: true
    validates :url, presence: true
    validates :price, presence: true


    def self.product_inspiration
        self.all.map {|product| puts "+ #{product.name}, £#{product.price} available from #{product.url} \n\n"}
    end

    def self.get_id_of_product_name(product_name)
        self.find_by("name = ?", product_name)
    end

    def self.find_associated_wish(product_name)
        find_wish = self.get_id_of_product_name(product_name).id
        Wish.find_by("product_id = ?", find_wish)
    end

end