class Cart
  attr_accessor :items

  def initialize
    @items = []
  end

  # Add item to cart
  # increment product if product exist in cart
  # @param [Product] product
  # @return [Array] items
  def add_item(product)
    found_item = @items.find { |item| item.name == product.name }

    if found_item
      found_item.increment
    else
      @items << product
    end
  end

  def clear
    @items = []
  end

  # Print cart items
  # print cart items and total
  def print_receipt
    print_header
    if @items.empty?
      puts 'Cart is empty'
      return
    end
    @items.each do |item|
      item.calculate_tax
      print_product_details(item)
    end
    @total_sales_taxes = @items.map(&:tax_total).sum
    @total = @items.map(&:total).sum
    print_total
    print_footer
  end

  private

  def print_header
    puts '************================************'
    puts '============ FUNKY STORE RECEIPT  ============'
    puts '************================************'
    puts "\n"
  end

  def print_product_details(product_item)
    puts "#{product_item.quantity} #{product_item.name}: #{format('%.2f', product_item.total)}"
  end

  def print_footer
    puts "\nThank you for purchasing at Funky Store!"
  end

  def print_total
    puts "Sales Taxes: #{format('%.2f', @total_sales_taxes)}"
    puts "Total: #{format('%.2f', @total)}"
  end
end
