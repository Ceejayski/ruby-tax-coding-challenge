require_relative 'spec_helper'

RSpec.describe Cart do
  let(:cart) { described_class.new }
  let(:product) { Product.new('book', 12.49, 1) }
  let(:product2) { Product.new('music cd', 14.99, 1) }
  let(:product3) { Product.new('chocolate bar', 0.85, 1) }

  describe '#initialize' do
    it 'returns a Cart' do
      expect(cart).to be_a(Cart)
    end

    it 'returns a Cart with empty products' do
      expect(cart.items).to be_empty
    end
  end

  describe '#add_item' do
    it 'should add product to cart' do
      cart.add_item(product)
      expect(cart.items).to eq([product])
    end

    it 'should increment product if product already exists' do
      cart.add_item(product)
      cart.add_item(product)
      expect(cart.items).to eq([product])
      expect(cart.items.first.quantity).to eq(2)
    end
  end
end
