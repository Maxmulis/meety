require 'rails_helper'

feature "get suggestions" do

  scenario "Passing two valid addresses", js: true do
    visit root_path
    fill_in("Your address", with: "Manteuffelstr. 77, 10999 Berlin")
    fill_in("Your friend's address", with: "Martin-Opitz-Straße 21, 13357 Berlin")
    click_on("🙅 Fire it up")

    expect(page).to have_selector('div.mapboxgl-marker', minimum: 3)
  end
end
