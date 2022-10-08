require_relative './constants'
require_relative '../services/tax_calculator'

class Product
  include Constants

  attr_reader :name
  attr_accessor :tax, :total, :category, :tax_total, :quantity, :price

  def initialize(name, price, quantity)
    @name = name
    @price = price
    @quantity = quantity
    # Set Product Category
    @category = determine_category
  end

  # Check if product is imported
  def imported?
    IMPORTED_KEYWORDS.any? { |word| @name.include?(word) }
  end

  # Increment Product quantiy and Price by 1
  def increment
    @quantity += 1
  end

  # Set Product Category according the defined keywords in CONSTANT
  def determine_category
    if DRUGS_KEYWORDS.any? { |word| @name.include?(word) }
      :medical
    elsif FOOD_KEYWORDS.any? { |word| @name.include?(word) }
      :food
    elsif BOOK_KEYWORDS.any? { |word| @name.include?(word) }
      :book
    else
      :other
    end
  end

  # Calculate Product Tax, updates product tax, tax_total and total
  def calculate_tax
    TaxCalculator.new(self).calculate
  end
end
