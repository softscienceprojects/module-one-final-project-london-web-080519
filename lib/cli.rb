class CommandLineInterface
    @logged_in_user = nil

    def prompt
        prompt = TTY::Prompt.new
        prompt
    end

    def greet
        p "  __      __.__       .__  "
        p " /  \    /  \__| _____|  |__ "
        p " \   \/\/   /  |/  ___/  |  \ "
        p "  \        /|  |\___ \|   Y  \ "
        p "   \__/\  / |__/____  >___|  /"
        p "        \/          \/     \/ "
 
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
        p "You have selected Make a Wish. Please enter your username: "
        get_user_by_username
        enter_new_product
    end

    def find_a_wish
        p "You have selected Find a Wish. Please enter the username of the Wish you want to find: "
        get_user_by_username
        "These are all the wishes associated with this username: "
        #show_all_wishes
    end

    def get_user_by_username
        the_username = prompt.ask()
        instance_of_user = User.find_or_create_by(username: the_username)
        @logged_in_user = instance_of_user
    end

    def enter_new_product
        product_name = prompt.ask("What is the product called?")
        product_url = prompt.ask("What's the URL of where we can find the product?")
        product_price = prompt.ask("How much does it cost?")
        product_delivery = prompt.ask("How long will it take to arrive?")
        
        Product.new(name: product_name, url: product_url, price: product_price, delivery_in_days: product_delivery)
    end

    def options_screen
        option_choice = prompt.select("Select what you would like to do:") do |menu|
            menu.choice 'See all Wishes', 1
            menu.choice 'Create a new Wish', 2
            menu.choice 'Update or delete a Wish', 3
            menu.choice 'Exit Wish', 4
        end
        if option_choice == 1
            see_all_wishes
        end
    end

    def see_all_wishes
        ## through User class
    end
    

end


