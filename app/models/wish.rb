class Wish < ActiveRecord::Base
belongs_to :user
belongs_to :product


    def update_a_wish
    end

    def delete_a_wish
    end

end