require_relative '../config/environment.rb'

#prompt.ask('What is your username?', default: ENV['USER'])

#prompt.yes? #confirms


class CommandLineInterface
    prompt = TTY::Prompt.new

    def greet
        p "Welcome to WISH, etc etc"
    end
    

    
    prompt.ask("What is your username?")
    

end


