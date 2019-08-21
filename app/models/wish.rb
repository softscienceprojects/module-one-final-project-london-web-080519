class Wish < ActiveRecord::Base
belongs_to :user
belongs_to :product

validates :quantity, presence: true
validates :occasion, presence: true

    def update_a_wish
    end

    def delete_a_wish(string_of_wish_to_delete)
        #take in string of the name of the Product
        string_of_wish_to_delete 
        #Find the Product instance with the string as the name

        #Find the ID of the Product instance

        #Find the wish with this product ID

        #DESTROY IT
        Wish.destroy_all(Wish.where("product_id = ?", Product.find_by("name= ?", their_selection).id)[0]) #.id
    end

end