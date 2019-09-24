require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do
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

  scenario "They see all products" do
    # ACT
    visit root_path

    # # DEBUG
    # save_screenshot

    # VERIFY

    expect(page).to have_css 'article.product'
    find('article.product:first-child').click
    # save_screenshot
    page.has_content?('Apparel')
    page.has_content?('Name')
    page.has_content?('Description')
    page.has_content?('Quantity')
    page.has_content?('Price')


    
    
  end
end
