require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    category = Category.find_or_create_by! name: 'Apparel'
    product = category.products.new(name: 'tshirt', price_cents:1300, quantity:3, description:"hello hello", image:'no image')
    # validation tests/examples here
    it "ensures that a product with all four fields will indeed save successfully" do
      expect(product).to be_valid
    end

    it "display invalid when name is set to be nil" do
      product.name = nil
      expect(product).to_not be_valid
      expect(product.errors[:name]).to_not be_empty
    end 

    it "display invalid when price is set to be nil" do
      product.price_cents = nil
      expect(product).to_not be_valid
      expect(product.errors[:price]).to_not be_empty
    end 

    it "display invalid when quantity is set to be nil" do
      product.quantity = nil
      expect(product).to_not be_valid
      expect(product.errors[:quantity]).to_not be_empty
    end 

    it "display invalid when description is set to be nil" do
      product.description = 'hello'
      expect(product.description).to eq('hello')
    end

    # it "display valid when image is set to be blank" do
    #   product.image = ''
    #   puts "current image i snow #{product.image}"
    #   expect(product.image).to eq('')
    # end 
    
  end
end
