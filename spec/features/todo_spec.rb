require 'rails_helper'
require 'byebug'

feature "The homepage" do
  background do
    create(:todo, id: 1234, title: "buy milk & eggs")
    visit "/"
  end

  scenario "should show my Todos" do
    expect(page).to have_content("buy milk & eggs")
  end

  scenario "should credit the author" do
    expect(page).to have_content("Created by Matt De Leon")
  end

  scenario "should show items remaining" do
    expect(page).to have_content("1 item left")
  end

  scenario "should contain edit instructions" do
    expect(page).to have_content("Double-click to edit a todo")
  end

  scenario "should remove item from list", js: true do
    # I can't get the button directly (no id)
    # But I can look for a button that is a descendent of a form!
    expect(page).to have_selector("form#edit_todo_1234 button")

    page.first("form#edit_todo_1234 button").click

    expect(page).to_not have_selector("form#edit_todo_1234 button")

    visit "/"

    expect(page).to_not have_content("buy milk & eggs")
  end

  scenario "should put a line through a completed item", js: true do
    expect(page).to have_selector("li#todo_1234")
    expect(page).to_not have_selector("li#todo_1234.completed")

    page.first("li#todo_1234 input.toggle").click

    expect(page).to have_selector("li#todo_1234.completed")
    expect(page).to have_content("0 items left")
  end
end
