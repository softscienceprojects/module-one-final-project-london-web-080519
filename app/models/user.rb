class User < ActiveRecord::Base
    has_many :wishes
    has_many :products, through: :wishes

    #As a User, I want to add a new Product
    #and associate it to a Wish

    def create_a_wish
        #Product.new(name: , url: , price: , delivery_in_days: )
    end

    #As a User, I want to see all my wishes
    def see_all_my_wishes
        self.wishes.find(self.id)
    end

    def describe_all_wishes
        puts "You wished for "
        self.wishes.map {|wish| puts "#{wish.id} - #{wish.quantity}x #{wish.product.name} that costs #{wish.product.price} each and is available from #{wish.product.url}"}
    end

    #As a User, I want to create a new product

    #and associated it to a wish

    #As a User, I want to select a product and delete it
 

end