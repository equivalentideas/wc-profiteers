require 'rails_helper'

feature "Viewing contractors", :type => :feature do
  scenario "visiting page and contractors are there" do
    contractor = create(:contractor)
    create(:contract, value: 10.00, description: 'Building things and knocking things down', contractor: contractor)
    create(:contract, can_id: '2', value: 10.00, description: 'Designing roads', contractor: contractor)

    visit root_path

    expect(page).to have_content 'Who profits from WestConnex?'
    expect(page).to have_content "#{contractor.name}"
    expect(page).to have_content "$20"
  end
end
