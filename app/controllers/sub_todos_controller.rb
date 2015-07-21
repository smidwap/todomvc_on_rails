class SubTodosController < ApplicationController
  helper_method :current_filter

  def index
    @sub_todos = SubTodo
  end

  def create
    @todo = Todo.find(params[:todo_id])

    @sub_todo = @todo.sub_todos.new(sub_todo_params)

    @sub_todo.save
  end

  def update
    @sub_todo = SubTodo.find(params[:id])
    @sub_todo.update(sub_todo_params)
  end

  def destroy
    @sub_todo = SubTodo.find(params[:id])
    @sub_todo.destroy
  end

  def toggle
    @sub_todo = SubTodo.find(params[:id])
    @sub_todo.toggle!(:completed)

    @todo = @sub_todo.todo
    @complete = Todo.check_all_subs(@todo)
  end

  private

  def sub_todo_params
    params.require(:sub_todo).permit(:title, :completed, :todo_id)
  end
end
