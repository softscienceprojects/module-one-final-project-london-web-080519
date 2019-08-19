require_relative '../config/environment.rb'

#prompt.ask('What is your username?', default: ENV['USER'])

#prompt.yes? #confirms


class CommandLineInterface

    def prompt
        prompt = TTY::Prompt.new
        prompt
    end

    def greet
        p "  __      __.__       .__  "
        p " /  \    /  \__| _____|  |__ "
        p " \   \/\/   /  |/  ___/  |  \ "
        p "  \        /|  |\___ \|   Y  \ "
        p "   \__/\  / |__/____  >___|  / "
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
        the_username = prompt.ask()
        get_user_by_username(the_username)

        #create user
        enter_new_product
    end

    def find_a_wish
        p "You have selected Find a Wish. Please enter the username of the Wish you want to find: "
        get_user_by_username
    end

    def get_user_by_username()
        instance_of_user = User.find_or_create_by(username: the_username)
        instance_of_user
    end

    def enter_new_product
        p "You are gonna enter a new product!"
    
    end

end


