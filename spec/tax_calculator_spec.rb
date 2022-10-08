require_relative 'spec_helper'

RSpec.describe TaxCalculator do
  let(:cart_items) do
    [
      Product.new('book', 12.49, 1),
      Product.new('imported chocolate', 14.99, 1),
      Product.new('music cd', 14.99, 1),
      Product.new('imported music cd', 14.99, 1),
      Product.new('chocolate bar', 0.85, 1)
    ]
  end
  let(:cart) { Cart.new(cart_items) }
  let(:tax_calculator) { described_class.new(cart_items[0]) }

  describe '#calculate' do
    it 'returns 0.00 for book' do
      tax_calculator.calculate
      expect(cart_items[0].tax_total).to eq(0.00)
    end

    context 'when product is imported' do
      let(:tax_calculator) { described_class.new(cart_items[1]) }

      it 'should call calculate_import_duty_tax' do
        allow(tax_calculator).to receive(:calculate_import_duty_tax).and_return(0.75)
        expect(tax_calculator).to receive(:calculate_import_duty_tax)
        tax_calculator.calculate
      end

      it 'returns 0.75 for imported music CD' do
        tax_calculator.calculate
        expect(cart_items[1].tax_total).to eq((cart_items[1].price * described_class::IMPORT_DUTY_TAX).round(2))
      end
    end

    context 'when product category is not exempted from tax' do
      let(:tax_calculator) { described_class.new(cart_items[2]) }

      it 'should call calculate_basic_tax' do
        allow(tax_calculator).to receive(:calculate_basic_tax).and_return(0.08)
        expect(tax_calculator).to receive(:calculate_basic_tax)
        tax_calculator.calculate
      end

      it 'returns 0.08 for music cd' do
        tax_calculator.calculate
        expect(cart_items[2].tax_total).to eq((cart_items[2].price * described_class::BASIC_SALE_TAX).round(2))
      end
    end

    context 'when product category is imported and not exempted from tax' do
      let(:tax_calculator) { described_class.new(cart_items[3]) }

      it 'should call calculate_basic_tax' do
        allow(tax_calculator).to receive(:calculate_basic_tax).and_return(0.08)
        expect(tax_calculator).to receive(:calculate_basic_tax)
        tax_calculator.calculate
      end

      it 'should call calculate_import_duty_tax' do
        allow(tax_calculator).to receive(:calculate_import_duty_tax).and_return(0.75)
        expect(tax_calculator).to receive(:calculate_import_duty_tax)
        tax_calculator.calculate
      end

      it 'returns 0.83 for imported music cd' do
        tax_calculator.calculate
        expect(cart_items[3].tax_total).to eq((cart_items[3].price * (described_class::BASIC_SALE_TAX + described_class::IMPORT_DUTY_TAX)).round(2))
      end
    end
  end
end
