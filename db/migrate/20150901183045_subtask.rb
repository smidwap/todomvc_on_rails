class Subtask < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.integer :todo_id, null: false
      t.boolean :completed, default: false, null: false
      t.string :title
      t.timestamps
    end
  end
end
