class Subtask < ActiveRecord::Base
  scope :completed, -> { where(completed: true) }
  scope :active, -> { where(completed: false) }

  belongs_to :todo

  def title=(title)
    write_attribute(:title, title.strip)
  end
end
