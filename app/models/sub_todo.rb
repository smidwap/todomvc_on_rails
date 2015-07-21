class SubTodo < ActiveRecord::Base
  scope :completed, -> { where("completed = ?", true) }
  scope :active, -> { where("completed = ?", false) }

  belongs_to :todo,
    class_name: 'Todo',
    foreign_key: :todo_id

  def title=(title)
    write_attribute(:title, title.strip)
  end

end
