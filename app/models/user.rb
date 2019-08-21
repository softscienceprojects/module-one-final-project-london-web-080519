require 'pry'
class User < ActiveRecord::Base
    has_many :wishes
    has_many :products, through: :wishes

    validates :username, presence: true


    def see_all_my_wishes
        self.wishes
    end

    def wish_text
        "#{wish.quantity}x #{wish.product.name} that costs #{wish.product.price} each and is available from #{wish.product.url}"
    end

    def describe_all_wishes
        if self.wishes.empty?
            puts "There are no Wishes yet. Enter a Wish to get started!"
        else
            puts "These are all the wishes associated with this username: "
            self.wishes.map {|wish| puts "#{wish.quantity}x #{wish.product.name} that costs #{wish.product.price} each and is available from #{wish.product.url}"}
        end
    end


   def wishes_by_quantity_ascending
        self.see_all_my_wishes.order(:quantity).map {|wish| puts "#{wish.quantity}x #{wish.product.name} that costs #{wish.product.price} each and is available from #{wish.product.url}"}
   end

    def wishes_in_range(low, high)
        self.see_all_my_wishes.select {|wish| wish.product.price > low && wish.product.price < high }.map{|wish| puts "#{wish.quantity}x #{wish.product.name} that costs #{wish.product.price} each and is available from #{wish.product.url}"}
    end

    def sort_wishes_by_occasion(occasion)
        occasion_selected =  self.see_all_my_wishes.where(occasion: occasion)
        occasion_selected.map {|wish| puts "#{wish.quantity}x #{wish.product.name} that costs #{wish.product.price} each and is available from #{wish.product.url}"}
    end

    def sort_wishes_by_date_created
        created_at = self.see_all_my_wishes.order(:created_at)
        created_at.map {|wish| puts "WISH MADE on #{wish.created_at.to_date}: #{wish.quantity}x #{wish.product.name} that costs #{wish.product.price} each and is available from #{wish.product.url}"}
      end


end