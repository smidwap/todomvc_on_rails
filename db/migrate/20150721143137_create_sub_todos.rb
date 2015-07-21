class CreateSubTodos < ActiveRecord::Migration
  def change
    create_table :sub_todos do |t|
      t.boolean :completed, default: false, null: false
      t.string :title
      t.integer :todo_id, null: false

      t.timestamps
    end
  end
end
