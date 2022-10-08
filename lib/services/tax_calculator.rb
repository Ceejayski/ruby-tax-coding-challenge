require_relative '../entities/constants'

class TaxCalculator
  include Constants

  def initialize(item)
    @item = item
  end

  # Calculate Product Tax, updates product tax, tax_total and total
  def calculate
    @item.tax = 0
    @item.tax += calculate_basic_tax
    # Check if product is imported and include import duty tax
    @item.tax += calculate_import_duty_tax if @item.imported?
    @item.tax = round_up_to_nearest_tax_round(@item.tax)
    @item.tax_total = @item.tax * @item.quantity
    @item.total = (@item.price * @item.quantity) + @item.tax_total
  end

  private

  # Calculate Basic Tax if product category is exempted  return 0 else return 10% of product total price
  def calculate_basic_tax
    return 0 if exempted_category?

    (@item.price * BASIC_SALE_TAX)
  end

  def round_up_to_nearest_tax_round(value)
    (value / NEAREST_ROUND).ceil * NEAREST_ROUND
  end

  # Calculate Import Duty Tax if product is imported return 5% of product total price
  def calculate_import_duty_tax
    (@item.price * IMPORT_DUTY_TAX)
  end

  # Check if product category is exempted
  def exempted_category?
    SPECIAL_EXEMPTED_CATEGORIES.include?(@item.category)
  end
end
