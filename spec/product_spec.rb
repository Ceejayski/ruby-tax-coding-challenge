require_relative 'spec_helper'

RSpec.describe Product do
  let(:product) { described_class.new('book', 12.49, 1) }

  describe '#initialize' do
    it 'returns a Product' do
      expect(product).to be_a(Product)
    end

    it 'returns a Product with quantity 1' do
      expect(product.quantity).to eq(1)
    end

    it 'returns Product with price 12.49' do
      expect(product.price).to eq(12.49)
    end

    it 'returns Product with name "book"' do
      expect(product.name).to eq('book')
    end

    it 'should set product category to books' do
      expect(product.category).to eq(:book)
    end

    it 'returns Product with tax_total 0.00' do
      product.calculate_tax
      expect(product.tax_total).to eq(0.00)
    end

    context 'if product category is food' do
      let(:product) { described_class.new('chocolate bar', 0.85, 1) }

      it 'should set product category to food' do
        expect(product.category).to eq(:food)
      end
    end

    context 'if product category is others' do
      let(:product) { described_class.new('music cd', 14.99, 1) }

      it 'should set product category to others' do
        expect(product.category).to eq(:other)
      end

      it 'should return product with tax_total 1.50' do
        product.calculate_tax
        expect(product.tax_total).to eq(1.50)
      end
    end
  end

  describe '#increment' do
    it 'should increment quantity by 1' do
      product.increment
      expect(product.quantity).to eq(2)
    end
  end
end
