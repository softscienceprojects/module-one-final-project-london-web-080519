require 'pastel'
require 'tty/font'
require 'tty/box'

  def welcome_to_wish
    pastel = Pastel.new
    font = TTY::Font.new(:standard)
    system 'clear'
    puts pastel.cyan(font.write('Welcome To'))
    puts pastel.cyan(font.write('  * - WISH - *'))
    puts pastel.white("Wish helps you and your loved ones keep track of the")
    puts pastel.white("presents and gifts that you would love to receive.")
  end

  def you_made_a_wish
    pastel = Pastel.new
    font = TTY::Font.new(:standard)
    system 'clear'
    puts pastel.cyan(font.write('You   Made   A'))
    puts pastel.cyan(font.write(' *  - WISH -  *'))
  end

  def exit_wish
    pastel = Pastel.new
    font = TTY::Font.new(:standard)
    system 'clear'
    puts pastel.cyan(font.write('Bye'))
    puts pastel.magenta(font.write('Bye'))
    puts pastel.white("Thanks for using Wish - we hope you enjoyed it!")
  end

welcome_to_wish
you_made_a_wish
exit_wish





#puts font.write("!#\$%^&*()-_+=")

#puts font.write("\"',.:;><?@][\\/}{|")
