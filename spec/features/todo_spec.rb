require 'rails_helper'

feature "The homepage" do
  background do
    create(:todo, title: "buy milk & eggs")
  end

  scenario "should show my Todos" do
    visit "/"
    expect(page).to have_content("buy milk & eggs")
  end

  scenario "should credit the author" do
    visit "/"
    expect(page).to have_content("Created by Matt De Leon")
  end

  scenario "should contain endit instructions" do
    visit "/"
    expect(page).to have_content("Double-click to edit a todo")
  end
end
