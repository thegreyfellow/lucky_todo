class Todos::Index < BrowserAction
  get "/todos" do
    json Todos::IndexSerializer.new
  end
end
