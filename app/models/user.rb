class User < ActiveRecord::Base
    has_many :wishes
    has_many :products, through: :wishes

    #As a User, I want to add a new Product
    #and associate it to a Wish

    def create_a_wish
        #Product.new(name: , url: , price: , delivery_in_days: )

        
    end

    #As a User, I want to see all my wishes


    #As a User, I want to create a new product

    #and associated it to a wish

    #As a User, I want to select a product and dete it


    

end