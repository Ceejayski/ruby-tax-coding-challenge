module Constants
  BASIC_SALE_TAX = 0.1
  IMPORT_DUTY_TAX = 0.05
  NEAREST_ROUND = 0.05
  DRUGS_KEYWORDS = %w[pills headache tablets].freeze
  FOOD_KEYWORDS = %w[chocolate bar milk vanilla].freeze
  BOOK_KEYWORDS = %w[book].freeze
  IMPORTED_KEYWORDS = %w[imported].freeze
  SPECIAL_EXEMPTED_CATEGORIES = %i[book food medical].freeze
end
