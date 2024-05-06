require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'pass with all fields present' do
      @category = Category.create(name: 'test')
      product = Product.new(name: 'test', description: 'test', image: 'test', price_cents: 100, quantity: 10, category_id: @category.id).save
      expect(product).to eq(true)
    end
    it 'fail when name is missing' do
      @category = Category.create(name: 'test')
      product = Product.new(name: nil, description: 'test', image: 'test', price_cents: 100, quantity: 10, category_id: @category.id)
      product.validate
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    it 'fail when price is missing' do
      @category = Category.create(name: 'test')
      product = Product.new(name: 'test', description: 'test', image: 'test', price_cents: nil, quantity: 10, category_id: @category.id)
      product.validate
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    it 'fail when quantity is missing' do
      @category = Category.create(name: 'test')
      product = Product.new(name: 'test', description: 'test', image: 'test', price_cents: 100, quantity: nil, category_id: @category.id)
      product.validate
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'fail when category is missing' do
      product = Product.new(name: 'test', description: 'test', image: 'test', price_cents: 100, quantity: 10, category_id: nil)
      product.validate
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
