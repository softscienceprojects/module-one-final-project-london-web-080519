require 'pry'
class CommandLineInterface
    attr_accessor :logged_in_user

    def initialize
        @logged_in_user = nil
    end

    def prompt
        prompt = TTY::Prompt.new(active_color: :cyan, help_color: :cyan)
        prompt
    end


    def greet
        welcome_to_wish
        get_response = prompt.select("What would you like to do?", [{'Make a Wish'=> -> do make_a_wish end}, {'Find a Wish'=>-> do find_a_wish end}])
    end



    def make_a_wish
        system 'clear'
        puts "You have selected Make a Wish. Please enter your username: "
        get_user_by_username
        enter_new_product
    end

    def find_a_wish
        system 'clear'
        puts "You have selected Find a Wish. Please enter the username of the Wish you want to find: "
        get_user_by_username
        see_all_wishes
        options_screen
    end

    def get_user_by_username
        the_username = prompt.ask()
        @logged_in_user = User.find_or_create_by(username: the_username)
    end

    def enter_new_product
        system 'clear'
        product_name = prompt.ask("What is the product called?")
        product_url = prompt.ask("What's the URL of where we can find the product? http://www.")
        product_price = prompt.ask("How much does it cost?")
        product_delivery = prompt.ask("How many days will it take to arrive?")
        
        Product.create(name: product_name, url: product_url, price: product_price, delivery_in_days: product_delivery)
        create_a_wish
    end


    def create_a_wish
        wish_qty = prompt.ask("Please enter how many #{Product.last.name} you would like to receive:")
        option_choice = prompt.select("Please select the occasion this wish is for:") do |menu|
            menu.choice 'Birthday'
            menu.choice 'Wedding'
            menu.choice 'Anniversary'
        end
        system 'clear'
        Wish.create(quantity: wish_qty, occasion: option_choice, user_id: logged_in_user.id, product_id: Product.last.id)
        puts "Congratulations! Your Wish has been made."
        return_to_options
    end

    def return_to_options
        prompt.keypress("Press any key to go back to the options screen")
        options_screen   
    end

    def options_screen
        system 'clear'
        options = [
            {'See all your Wishes' => -> do see_all_wishes end},
            {'Create a new Wish'=>-> do enter_new_product end},
            {'Update or delete a Wish'=>-> do update_or_delete_a_wish end},
            {'Find someone else\'s wishes'=>-> do find_a_wish end},
            {'Exit Wish'=>-> do puts "Thank you for using Wish. Good-bye!" 
            exit 
            end}
        ]
        
        option_choice = prompt.select("What would you like to do next?", options) 
    end

    def see_all_wishes
       system 'clear'
       @logged_in_user.wishes.reload
       @logged_in_user.describe_all_wishes
       if @logged_in_user.wishes.empty?
        return_to_options
       end
       prompt.select("Would you like to filter these wishes?", [{"Yes"=>-> do filter_wishes end}, {"No"=>-> do return_to_options end}])
    end

    def filter_wishes
        options = [
            {'Get wishes in a price bracket'=>-> do get_wishes_in_price_bracket end},
            {'Get wishes by quantity (low to high)'=>-> do order_wishes_by_quantity_ascending end},
            {'Get wishes by occasion'=>-> do get_wishes_by_occasion end},
            {'Cancel and go back to main menu'=>-> do options_screen end}
        ]
        option_choice = prompt.select("How would you like to filter the results?", options) 
    end

    def get_wishes_by_occasion
        occasion = prompt.select("What occasion would you like to see Wishes for?", ["Birthday", "Wedding", "Anniversary"])
        @logged_in_user.sort_wishes_by_occasion(occasion)
        return_to_options
    end

    def order_wishes_by_quantity_ascending
        @logged_in_user.wishes_by_quantity_ascending
        return_to_options
    end

    def get_wishes_in_price_bracket
        puts "Enter the minimum you will spend:"
        min = gets.chomp.to_f
        puts "Enter the maximum you wish to spend:"
        max = gets.chomp.to_f
        puts "Here are the wishes in that price range:"
        @logged_in_user.wishes_in_range(min, max)
        return_to_options
    end

    def update_or_delete_a_wish
        if @logged_in_user.wishes.empty?
            see_all_wishes
        end
        if @logged_in_user.wishes != nil
            their_selection = prompt.select('Please select the wish you would like to update or delete:', @logged_in_user.show_users_their_wishes)
            wish_to_edit = Product.find_associated_wish(their_selection)
            update_or_delete = prompt.select("Would you like to update or delete a wish?", ["Update", "Delete", "Cancel and go back to options"])
            case update_or_delete 
                when "Delete"
                prompt.select("Are you sure?", [{"Yes"=>-> do Wish.delete_associated_wish(wish_to_edit) end}, {"No"=>-> do puts "Your wish has been deleted" end}])
                when "Update"
                    puts "You have asked for #{wish_to_edit.quantity} of #{their_selection}. What would you like to change it to?"
                    new_quantity = gets.chomp
                    wish_to_edit.update(quantity: new_quantity)
                    puts "your Wish quantity is now #{wish_to_edit.quantity}"
            end
        end
        return_to_options
    end


end


