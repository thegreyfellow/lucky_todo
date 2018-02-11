require "../../spec_helper"

describe Todos::Show do
  request = RequestSpecHelper.new
  todo_body = {
    "todo" => {
      "title" => "todo_title",
      "description" => "todo_description"
    }
  }
  response_body = JSON.build do |json|
    json.field "todo" do
      json.field "id", 1
      json.field "title", "todo_title"
      json.field "description", "todo_description"
    end
  end

  context "todo exists" do
    # it "responds with 200" do
    #   TodoForm.create(todo_body) do |form, todo|
    #     if todo
    #       response = request.get("/todos/1")
    #       response.code.should eq(200)
    #       response.contain(response_body)
    #     end
    #   end
    # end
  end

  context "todo does not exist" do
    it "responds with 404" do
      response = request.get("/todos/1")
      response.status_code.should eq(404)
    end
  end
end
