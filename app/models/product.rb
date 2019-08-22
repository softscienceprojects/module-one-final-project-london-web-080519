class Product < ActiveRecord::Base
    has_many :wishes
    has_many :users, through: :wishes

    validates :name, presence: true
    validates :url, presence: true
    validates :price, presence: true
    validates_numericality_of :price
    validates_numericality_of :delivery_in_days, :only_integer => true

    def self.show_error_message(new_product)
        if new_product.errors.messages.map { |field, error| puts "#{field.upcase}: #{error[0]}." }
        end
    end

    def self.make_new_product(product_name, product_url, product_price, product_delivery)
        new_product = self.create(name: product_name, url: product_url, price: product_price, delivery_in_days: product_delivery)
        if new_product.errors.messages.keys.nil? == false
            self.show_error_message(new_product)
        end
        new_product
    end


    def self.product_inspiration
        self.all.map {|product| puts "⬡ #{product.name}, £#{product.price} \n\n"}
    end

    def self.get_id_of_product_name(product_name)
        self.find_by("name = ?", product_name)
    end

    def self.find_associated_wish(product_name)
        find_wish = self.get_id_of_product_name(product_name).id
        Wish.find_by("product_id = ?", find_wish)
    end

    def make_a_wish_come_true
        new_string = "http://www."+ self.url
        open new_string
    end

end