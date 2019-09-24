require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
  before :each do 
    @category = Category.create(
      :name => 'Apparel'
    )

    10.times do |n|
      @category.products.create(
        :name => Faker::Hipster.sentence(3),
        :description => Faker::Hipster.paragraph(4),
        :image => open_asset('apparel1.jpg'),
        :quantity => 5,
        :price => 2.99
      )
    end
  end

  scenario 'they should be able to add to chart' do
    visit root_path
    expect(page).to have_css 'article.product'
    click_button('Add', match: :first)
    page.has_content?('My Cart(1)')
  end

end
