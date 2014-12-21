require "rails_helper"

RSpec.describe Todo, :type => :model do

  before do
    @todo = FactoryGirl.create(:todo)
  end

  subject { @todo }

  it { should respond_to :title }
  it { should respond_to :completed }

  it "should be able to get filterd item" do

    @todo.destroy

    FactoryGirl.create_list(:todo, 3)
    FactoryGirl.create_list(:todo, 3, :completed)

    Todo.active.each do |todo|
      expect(todo.completed).to be_falsy
    end

    Todo.completed.each do |todo|
      expect(todo.completed).to be_truthy
    end
  end
end
