require_relative 'entities/cart_item'
require_relative 'entities/cart'
require 'colorize'

class PurchaseTaxReceiptGenerator
  OPTIONS = { q: 'Print Receipt and exit cli', c: 'Clear list', p: 'Print Receipt' }.freeze

  # Execute the cli
  def self.execute
    print '>  '
    input = gets.chomp.strip
    cart = Cart.new
    until input == 'q'

      case input
      when 'c'
        # clear list - if 'c' is pressed, clear the list
        cart.clear
        puts 'Cart cleared'.yellow
      when 'p'
        # print receipt - if 'p' is pressed, print the receipt
        cart.print_receipt
      when ''
        # do nothing - if nothing is entered, break loop
        break
      else
        # add item - if item is entered, add it to the list
        begin
          # parse the input and add it to the cart
          product = CartItem.parse(input)
          cart.add_item(product)
        rescue CartItem::InvalidQuantityError, CartItem::InvalidPriceError, CartItem::InvalidNameError => e
          # if the input is invalid, print the error message
          puts "#{e.message}, Please use this format: 1 book at 12.49".red
        rescue StandardError => e
          puts 'Something went wrong, please try again'.red
          puts e.message
        end
      end
      print_options
      print '>  '
      input = gets.chomp.strip
    end
    cart.print_receipt
  end

  def self.print_options
    puts "Press #{'c'.green} to clear list, #{'p'.green} to print receipt or #{'q'.green} to quit: "
    puts 'Please enter your options or items using the format above: '.yellow
  end
end
