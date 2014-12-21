require "rails_helper"

feature "Todos", :type => :feature do

  feature "get /" do
    scenario "should show all todos" do
      visit "/"
      check_todo(page, 0, 0, :all)

      # add task
      FactoryGirl.create_list(:todo, 2)
      FactoryGirl.create_list(:todo, 3, :completed)
      visit "/"
      check_todo(page, 2, 3, :all)
    end
  end

  feature "get /todos/active" do
    scenario "should show only active todo" do
      FactoryGirl.create_list(:todo, 2)
      FactoryGirl.create_list(:todo, 3, :completed)
      visit "/todos/active"
      check_todo(page, 2, 3, :active)
    end
  end

  feature "get /todos/completed" do
    scenario "should show only completed todo" do
      FactoryGirl.create_list(:todo, 2)
      FactoryGirl.create_list(:todo, 3, :completed)
      visit "/todos/completed"
      check_todo(page, 2, 3, :completed)
    end
  end

  feature "clicking completed checkbox of the certain todo" do
    scenario "should toggled todo's completed attribute in html", js: true do
      todo = FactoryGirl.create(:todo)
      visit "/"
      checkbox = page.find(get_todo_selector(todo) + " input[type=checkbox]")

      # toggle for completed
      checkbox.click
      wait_for_ajax
      expect(page.has_css?(get_todo_selector(todo) + ".completed")).to be_truthy

      # toggle for active
      checkbox.click
      wait_for_ajax
      expect(page.has_css?(get_todo_selector(todo) + ".completed")).to be_falsy
    end
  end

  feature "clicking all-completed checkbox" do
    scenario "should toggled all todo's attribute in html" , js: true do
      todos = FactoryGirl.create_list(:todo, 3)
      visit "/"
      toggle_all_checkbox = page.find("#toggle-all")

      # toggle all for completed
      toggle_all_checkbox.click
      wait_for_ajax
      todos.each do |todo|
        expect(page.has_css?(get_todo_selector(todo) + ".completed")).to be_truthy
      end

      # toggle all for active
      toggle_all_checkbox.click
      wait_for_ajax
      todos.each do |todo|
        expect(page.has_css?(get_todo_selector(todo) + ".completed")).to be_falsy
      end
    end
  end

  feature "new todo title is inputed" do
    scenario "new todo should create in html" , js:true do
      visit "/"
      # input text with enter
      page.find("#new-todo").set("create new todo test \n")
      wait_for_ajax
      inputed_title = page.find("#todo-list li [data-behavior=todo_title]")
      expect(inputed_title.assert_text("create new todo test")).to be_truthy
    end
  end

  feature "todo's title is doble clicked" do
    scenario "todo's title should able to update title in html", js: true do
      todo = FactoryGirl.create(:todo)
      visit "/"
      todo_dom = page.find(get_todo_selector(todo))
      todo_dom.double_click
      todo_edit_node = page.find(get_todo_selector(todo) + " [data-behavior=todo_title_input]")
      # edit title with enter
      todo_edit_node.set("update new todo test \n")
      wait_for_ajax
      inputed_title = page.find(get_todo_selector(todo) + " [data-behavior=todo_title]")
      expect(inputed_title.assert_text("update new todo test")).to be_truthy
    end
  end

  feature "todo's completed checkbox is clicked" do
    scenario "todo should be deleted in html", js: true do
      todo = FactoryGirl.create(:todo)
      visit "/"
      page.find(get_todo_selector(todo)).hover
      page.find(get_todo_selector(todo) + " button.destroy").click
      wait_for_ajax
      check_todo(page, 0, 0, :all)
    end
  end

  feature "todo's all-completed checkbox is clicked" do
    scenario "all todos should be deleted in html", js: true do
      FactoryGirl.create_list(:todo, 5, :completed)
      visit "/"
      click_button("clear-completed")
      wait_for_ajax
      check_todo(page, 0, 0, :all)
    end
  end

end
