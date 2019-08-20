class Wish < ActiveRecord::Base
belongs_to :user
belongs_to :product

validates :quantity, presence: true
validates :occasion, presence: true

    def update_a_wish
    end

    def delete_a_wish
    end

end