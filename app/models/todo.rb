class Todo < ActiveRecord::Base
  scope :completed, -> { where("completed = ?", true) }
  scope :active, -> { where("completed = ?", false) }

  has_many :subtasks

  def title=(title)
    write_attribute(:title, title.strip)
  end
end
