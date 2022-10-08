require_relative 'spec_helper'

RSpec.describe CartItem do
  let(:product) { '1 lord of the rings book at 12.49' }
  let(:cart_item) { described_class.parse(product) }

  describe '.parse' do
    it 'returns a Product' do
      expect(cart_item).to be_a(Product)
    end

    it 'returns a Product with quantity 1' do
      expect(cart_item.quantity).to eq(1)
    end

    it 'returns Product with price 12.49' do
      expect(cart_item.price).to eq(12.49)
    end

    it 'returns Product with name "book"' do
      expect(cart_item.name).to eq('lord of the rings book')
    end

    context 'when product quantity is invalid' do
      let(:product) { 'das book at 12.49' }

      it 'raises InvalidQuantityError' do
        expect { cart_item }.to raise_error(CartItem::InvalidQuantityError)
      end
    end

    context 'when product price is invalid' do
      let(:product) { '1 book at das' }

      it 'raises InvalidPriceError' do
        expect { cart_item }.to raise_error(CartItem::InvalidPriceError)
      end
    end

    context 'when product name is invalid' do
      let(:product) { '1 at 12.49' }

      it 'raises InvalidNameError' do
        expect { cart_item }.to raise_error(CartItem::InvalidNameError)
      end
    end
  end
end
