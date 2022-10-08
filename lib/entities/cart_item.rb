require_relative '../entities/product'

class CartItem
  # Error raised when the quantity is invalid
  class InvalidQuantityError < StandardError
    def initialize(msg = 'Invalid quantity, must be number and must be greater than 0')
      super
    end
  end

  # Error raised when the price is invalid
  class InvalidPriceError < StandardError
    def initialize(msg = 'Invalid price, must be number and must be greater than 0')
      super
    end
  end

  # Error raised when the name is invalid
  class InvalidNameError < StandardError
    def initialize(msg = 'Invalid must not be empty')
      super
    end
  end

  class << self
    # Parse the product string and return a Product
    def parse(product_text)
      @words = product_text.strip.split(' ').reject { |word| word == '' }

      product_quantity = quantity
      product_price = price
      product_name = name

      Product.new(product_name, product_price, product_quantity)
    end

    private

    # Parse the quantity from the product string returns and integer
    def quantity
      number = @words.first.strip.to_i
      raise InvalidQuantityError unless number.positive?

      number
    end

    # Parse the price from the product string returns and float
    def price
      number = @words.last.strip.to_f
      raise InvalidPriceError unless number.positive?

      number
    end

    # Parse the name from the product string
    def name
      name = @words[1...(@words.length - 2)].join(' ')
      raise InvalidNameError if name.empty?

      name
    end
  end
end
