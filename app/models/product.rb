class Product < ActiveRecord::Base
    has_many :wishes
    has_many :users, through: :wishes

end