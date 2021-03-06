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
        get_response = prompt.select("What would you like to do?", [{'MAKE a Wish'=> -> do make_a_wish end}, {'FIND a Wish'=>-> do find_a_wish end}])
    end


    def make_a_wish
        puts "You have selected Make a Wish. Please enter your chosen username: "
        get_user_by_username
        enter_new_product
    end

    def find_a_wish
        system 'clear'
        puts "You have selected Find a Wish. Please enter the username of the Wish you want to find: "
        find_user_by_username
        see_all_wishes
        options_screen
    end

    def get_user_by_username
        the_username = prompt.ask()
        @logged_in_user = User.find_or_create_by(username: the_username)
        if the_username == nil
            @logged_in_user.show_error_message
            make_a_wish
        end
    end

    def find_user_by_username
        the_username = prompt.ask()
        ##below to User class logic 
        if  User.find_by(username: the_username)
            @logged_in_user = User.find_by(username: the_username)
        else
            puts "There is no user by the username, #{the_username}!"
            prompt.select("\n Please choose whether you would like to try again or exit", [{"SEARCH again"=>-> do find_a_wish end}, {"START again"=>-> do greet end}, {"EXIT"=>-> do exit_wish
                exit 
            end},])
        
        end
    end


    def enter_new_product
        system 'clear'
        product_name = prompt.ask("What is the product you would like to wish for called?")
        product_url = prompt.ask("What's the URL of where we can find the product?")
        product_price = prompt.ask("How much does it cost?")
        product_delivery = prompt.ask("How many days will it take to arrive?")
        
        new_product = Product.make_new_product(product_name, product_url, product_price, product_delivery)
        
        if new_product.id == nil
            puts "\n ERROR! We can't save your wish until the errors above are corrected."
            return_to_options
        end
       # Product.create(name: product_name, url: product_url, price: product_price, delivery_in_days: product_delivery)
        create_a_wish
    end

    def try_wish_again
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
        you_made_a_wish
        return_to_options
    end

    def return_to_options
        prompt.keypress("Press any key to go back to the options screen")
        options_screen   
    end

    def options_screen
        system 'clear'
        options = [
            {'SEE Wishes' => -> do see_all_wishes end},
            {'CREATE a new Wish'=>-> do enter_new_product end},
            {'UPDATE or delete a Wish'=>-> do update_or_delete_a_wish end},
            {'FIND someone else\'s wishes'=>-> do find_a_wish end},
            {'GET INSPIRED and see what everyone has wished for'=>-> do see_all_products end},
            {'EXIT Wish'=>-> do exit_wish 
            exit 
            end}
        ]
        option_choice = prompt.select("What would you like to do next?", options) 
    end


    def see_all_wishes
       system 'clear'
       @logged_in_user.describe_all_wishes
       if @logged_in_user.wishes.empty?
        return_to_options
       end
       prompt.select("\n Would you like to filter these wishes?", [{"Yes"=>-> do filter_wishes end}, {"No, return to options"=>-> do return_to_options end}, {'Make a Wish come true'=>-> do open_a_wish end},])
    end

    def filter_wishes
        options = [
            {'Get wishes in a PRICE BRACKET'=>-> do get_wishes_in_price_bracket end},
            {'Get wishes by QUANTITY (low to high)'=>-> do order_wishes_by_quantity_ascending end},
            {'Get wishes by OCCASION'=>-> do get_wishes_by_occasion end},
            {'Get wishes by DATE CREATED'=>-> do get_wishes_by_date end},
            {'BACK to main menu'=>-> do options_screen end}
        ]
        option_choice = prompt.select("How would you like to filter the results?", options) 
    end

    def get_wishes_by_date
        puts "These are all the wishes associated with this username, listed by date created"
        @logged_in_user.sort_wishes_by_date_created
        return_to_options
    end

    def get_wishes_by_occasion
        occasion = prompt.select("What occasion would you like to see Wishes for?", ["Birthday", "Wedding", "Anniversary"])
        puts "These are all the wishes associated with this username, for the occasion - #{occasion}."
        result = @logged_in_user.sort_wishes_by_occasion(occasion)
        if result.empty? 
            puts "There are no wishes for that occasion!"
        end
        result
        return_to_options
    end

    def order_wishes_by_quantity_ascending
        puts "These are all the wishes associated with this username, ordered by quantity:"
        @logged_in_user.wishes_by_quantity_ascending
        return_to_options
    end

    def get_wishes_in_price_bracket
        puts "Enter the MINIMUM you will spend:"
        min = gets.chomp.to_f
        puts "Enter the MAXIMUM you wish to spend:"
        max = gets.chomp.to_f
        puts "Here are the wishes in that price range:"
        results = @logged_in_user.wishes_in_range(min, max)
        if results.empty?
            puts "There are no wishes in that price range!"
        end
        results
        return_to_options
    end

    def see_all_products
        puts "These are all the products people have wished for:"
        Product.product_inspiration
        return_to_options
    end


    def open_a_wish 
        their_selection = prompt.select("Select a Wish from the below that you would like to purchase:", @logged_in_user.show_users_their_wishes)
        wish_to_open = Product.find_associated_wish(their_selection)
        @logged_in_user.select_a_wish(wish_to_open)
        return_to_options
    end


    def update_or_delete_a_wish
        if @logged_in_user.wishes.empty?
            see_all_wishes
        end
        if @logged_in_user.wishes != nil
            their_selection = prompt.select('Please select the wish you would like to update or delete:', @logged_in_user.show_users_their_wishes)
            wish_to_edit = Product.find_associated_wish(their_selection)
            update_or_delete = prompt.select("Would you like to update or delete this wish?", ["UPDATE", "DELETE", "CANCEL and go back to options"])
            case update_or_delete 
                when "DELETE"
                    delete_a_wish(wish_to_edit)
                when "UPDATE"
                    update_a_wish(wish_to_edit)
            end
        end
        return_to_options
    end


    def delete_a_wish(wish_to_edit)
        prompt.select("Are you sure?", [{"Yes"=>-> do Wish.delete_associated_wish(wish_to_edit) end}, {"No"=>-> do return_to_options end}])
    end

    def update_a_wish(wish_to_edit)
        puts "You have asked for #{wish_to_edit.quantity} of #{wish_to_edit.product.name}. What would you like to change it to?"
        new_quantity = gets.chomp
        wish_to_edit.update(quantity: new_quantity)
        puts "Your Wish quantity is now #{wish_to_edit.quantity}"
        return_to_options
    end

end


