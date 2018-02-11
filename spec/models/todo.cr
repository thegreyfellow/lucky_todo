require "../spec_helper"

describe Todo do
  it "contains title : String" do
    todo = Todo.new
    todo.should be_a(Todo)
  end
end
