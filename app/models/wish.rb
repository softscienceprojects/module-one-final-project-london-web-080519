class Wish < ActiveRecord::Base
belongs_to :user
belongs_to :product

validates :quantity, presence: true
validates :occasion, presence: true

    def update_a_wish(their_wish)
    end

    def find_wish_from_product
        self.find_by("product_id = ?", found_product)
    end
    
    # def self.delete_a_wish(string_of_wish_to_delete)
    #       Wish.destroy_all(Wish.where("product_id = ?", Product.find_by("name= ?", string_of_wish_to_delete).id)[0]) #.id
    # end

    def self.delete_associated_wish(their_wish)
        self.destroy(their_wish.id)
    end

end