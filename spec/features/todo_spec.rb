require 'rails_helper'

feature "The homepage" do
  background do
    create(:todo, title: "buy milk & eggs")
  end

  scenario "should show my Todos" do
    visit "/"
    expect(page).to have_content("buy milk & eggs")
  end
end
