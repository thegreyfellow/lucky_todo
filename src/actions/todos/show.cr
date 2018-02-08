class Todos::Show < BrowserAction
  get "/todos/:id" do
    json Todos::ShowSerializer.new(TodoQuery.new.find(id))
  end
end
