class Todo < ActiveRecord::Base
  scope :completed, -> { where("completed = ?", true) }
  scope :active, -> { where("completed = ?", false) }

  has_many :sub_todos,
    class_name: 'SubTodo',
    foreign_key: :todo_id

  def title=(title)
    write_attribute(:title, title.strip)
  end

  def self.check_all_subs(todo)
    all_complete = true
    todo.sub_todos.each do |sub_todo|
      all_complete = false if !sub_todo.completed
    end

    if todo.completed
      todo.update(completed: false)
    elsif all_complete
      todo.update(completed: true)
    else
      return false
    end

    true
  end
end
