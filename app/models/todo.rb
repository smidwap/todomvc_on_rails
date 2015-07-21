class Todo < ActiveRecord::Base
  scope :completed, -> { where("completed = ?", true) }
  scope :active, -> { where("completed = ?", false) }

  has_many :sub_todos,
    class_name: 'SubTodo',
    foreign_key: :todo_id

  def title=(title)
    write_attribute(:title, title.strip)
  end
end
