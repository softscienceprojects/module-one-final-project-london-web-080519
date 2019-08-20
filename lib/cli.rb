require 'pry'
class CommandLineInterface
    attr_accessor :logged_in_user

    def initialize
        @logged_in_user = nil
    end

    def prompt
        prompt = TTY::Prompt.new
        prompt
    end

    def greet
        puts "  __      __.__       .__  "
        puts " /  \    /  \__| _____|  |__ "
        puts " \   \/\/   /  |/  ___/  |  \ "
        puts "  \        /|  |\___ \|   Y  \ "
        puts "   \__/\  / |__/____  >___|  /"
        puts "        \/          \/     \/ "
 
        p "Welcome!"
        get_response = prompt.select("What would you like to do?", ['Make a Wish', 'Find a Wish'])
            #get their response
            if  get_response == 'Make a Wish'
                make_a_wish
            else
                find_a_wish
            end
    end
    
    def make_a_wish
        puts "You have selected Make a Wish. Please enter your username: "
        get_user_by_username
        enter_new_product
    end

    def find_a_wish
        puts "You have selected Find a Wish. Please enter the username of the Wish you want to find: "
        get_user_by_username
        puts "These are all the wishes associated with this username: "
        options_screen
        return_to_options
    end

    def get_user_by_username
        the_username = prompt.ask()
        @logged_in_user = User.find_or_create_by(username: the_username)
    end

    def enter_new_product
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

        Wish.create(quantity: wish_qty, occasion: option_choice, user_id: logged_in_user.id, product_id: Product.last.id)
        puts "Congratulations! Your Wish has been made."
        return_to_options
    end

    def options_screen
        option_choice = prompt.select("What would you like to do next?") do |menu|
            menu.choice 'See all your Wishes', 1
            menu.choice 'Create a new Wish', 2
            menu.choice 'Update or delete a Wish', 3
            menu.choice 'Find someone else\'s wishes', 4
            menu.choice 'Exit Wish', 5
        end
        case option_choice
            when 1
                see_all_wishes
            when 2
                enter_new_product
            when 3
                update_or_delete_a_wish
            when 4
                find_a_wish
            when 5
                puts "Thank you for using Wish. Good-bye!"
        end
    end

    def see_all_wishes
       @logged_in_user.wishes.reload
       @logged_in_user.describe_all_wishes
    end
    
    def return_to_options
        prompt.keypress("Press any key to go back to the options screen")
        options_screen   
    end

    def update_or_delete_a_wish
        see_all_wishes
        their_selection = prompt.ask("Please select the wish you would like to update or delete: ")
        wish_to_edit = Wish.find(their_selection)
        update_or_delete = prompt.select("Would you like to update or delete?", ["Update", "Delete"])
        case update_or_delete 
            when "Delete"
                "Are you sure?"
                    yes_or_no = prompt.select("Are you sure?", ["Yes", "No"])
                     if yes_or_no == "Yes"
                        wish_to_edit.destroy
                    else
                        return_to_options
                    end
            when "Update"
                puts "Your Wish quantity is #{wish_to_edit.quantity}. What would you like to change it to?"
                new_quantity = gets.chomp
                wish_to_edit.update(quantity: new_quantity)
                puts "your Wish quantity is now #{wish_to_edit.quantity}"
                return_to_options
        end
        
    end

end


