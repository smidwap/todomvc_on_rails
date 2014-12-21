module ViewHelper
  def get_todo_list(page, filter)

    cls_filter = ""
    if(filter == :active) then
      cls_filter = ":not(.completed)"
    elsif(filter == :completed) then
      cls_filter = ".completed"
    else
      cls_filter = ""
    end
    page.all("#todo-list li#{cls_filter}")
  end

  def check_todo(page, expect_active, expect_completed, filter)

    expect_all = expect_active + expect_completed
    expect_completed_text = "Clear completed (" + expect_completed.to_s + ")"
    all = get_todo_list(page, :all).size
    active = get_todo_list(page, :active).size
    completed = get_todo_list(page, :completed).size

    # list
    if(filter == :active) then
      expect(all).to eq(expect_active)
      expect(active).to eq(expect_active)
      expect(completed).to eq(0)
    elsif(filter == :completed) then
      expect(all).to eq(expect_completed)
      expect(active).to eq(0)
      expect(completed).to eq(expect_completed)
    else
      expect(all).to eq(expect_all)
      expect(active).to eq(expect_active)
      expect(completed).to eq(expect_completed)
    end

    # footer
    if expect_all != 0 then
      item_num = page.find("#todo-count strong").text.to_i
      expect(item_num).to eq(expect_active)
    end
    if expect_completed > 0 then
      completed_text = page.find("#clear-completed").text
      expect(completed_text).to eq(expect_completed_text)
    end

  end

  def get_todo_dom_id(todo)
    ActionView::RecordIdentifier.dom_id(todo)
  end

  def get_todo_selector(todo)
    "#" + get_todo_dom_id(todo)
  end

end

RSpec.configure do |config|
  config.include ViewHelper, type: :feature
end
