require "rails_helper"

RSpec.describe TodosController, :type => :controller do

  before(:each) do
    @todo = FactoryGirl.create(:todo)
    @todo_completed = FactoryGirl.create(:todo, :completed)
    request.env["HTTP_ACCEPT"] = "application/javascript"
  end

  describe ":index action" do
    it "should be success" do
      get :index
      expect(response).to be_success
    end
  end

  describe ":create action" do
    it "should be success" do
      post :create, todo: {title: "test task 1"}
      expect(response).to be_success
    end
    it "shoud add new task" do
      post :create, todo: {title: "test task 1"}
      expect(Todo.last.title).to eq("test task 1")
      Todo.last.destroy
    end
  end

  describe ":update action" do
    it "should be success" do
      put :update, :id => @todo, todo: {title: "updated test task"}
      expect(response).to be_success
    end
    it "should update the task" do
      expect(Todo.find(@todo.id).title).not_to eq("updated test task")
      put :update, :id => @todo, todo: {title: "updated test task"}
      expect(Todo.find(@todo.id).title).to eq("updated test task")
    end
  end

  describe ":toggle action" do
    it "should be success" do
      post :toggle, :id => @todo
      expect(response).to be_success
    end
    it "should toggle completed attribute of a todo" do
      expect(@todo.completed).to be_falsy
      post :toggle, :id => @todo
      expect(Todo.find(@todo.id).completed).to be_truthy
    end
  end

  describe ":toggle_all action" do
    it "should be success" do
      post :toggle_all
      expect(response).to be_success
    end
    it "should toggle completed attribute of all todos" do
      Todo.destroy_all
      FactoryGirl.create_list(:todo, 2, :completed)
      expect(Todo.completed.size).to eq(2)
      post :toggle_all
      expect(Todo.completed.size).to eq(0)
    end
  end

  describe ":active action" do
    it "should be success" do
      get :active
      expect(response).to be_success
    end
    it "should set filter to @current_filter" do
      get :active
      expect(assigns[:current_filter]).to eq(:active)
    end
  end

  describe ":completed action" do
    it "should be success" do
      get :completed
      expect(response).to be_success
    end
    it "should set filter to @current_filter" do
      get :completed
      expect(assigns[:current_filter]).to eq(:completed)
    end
  end

  describe ":destroy action" do
    it "should be success" do
      delete :destroy, :id => @todo
      expect(response).to be_success
    end
    it "should delete a todo" do
      expect(Todo.where("id = ?", @todo.id).size).to eq(1)
      delete :destroy, :id => @todo
      expect(Todo.where("id = ?", @todo.id).size).to eq(0)

      # You can also check wether there is an error or not.
      ## expect{ Todo.find(@todo.id) }.to_not raise_error()
      ## delete :destroy, :id => @todo
      ## expect{ Todo.find(@todo.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ":destroy_completed action" do
    it "should be success" do
      delete :destroy_completed
      expect(response).to be_success
    end
    it "should delete all completed todo" do
      Todo.destroy_all
      FactoryGirl.create_list(:todo, 10, :completed)
      expect(Todo.completed.size).to eq(10)
      delete :destroy_completed
      expect(Todo.completed.size).to eq(0)
    end
  end

end
