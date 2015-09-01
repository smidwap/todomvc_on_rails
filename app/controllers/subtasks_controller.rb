class SubtasksController < ApplicationController
  def create
    @subtask = todo.subtasks.new(subtask_params)
    @subtask.save
  end

  def toggle
    subtask.toggle!(:completed)
  end

  def update
    subtask.update(subtask_params)
  end

  def destroy
    subtask.destroy
  end

  private

  def subtask_params
    params.require(:subtask).permit(:title, :completed)
  end

  def subtask
    @subtask ||= todo.subtasks.find(params[:id])
  end

  def todo
    @todo ||= Todo.find(params[:todo_id])
  end
end