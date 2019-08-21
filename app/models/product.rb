class Product < ActiveRecord::Base
    has_many :wishes
    has_many :users, through: :wishes

    validates :name, presence: true
    validates :url, presence: true
    validates :price, presence: true


    def product_name_and_price
        "#{name}, £#{price}"
    end

    def self.get_id_of_product_name(product_name)
        self.find_by("name = ?", product_name)
    end

    def self.see_all_products
        #see what everyone else has wished for to 'get ideas'
        self.all
    end

    #given the name of a product, find its associated wish
    def self.find_associated_wish(product_name)
        find_wish = self.get_id_of_product_name(product_name).id
        Wish.find_by("product_id = ?", find_wish)
    end

end