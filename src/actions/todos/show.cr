class Todos::Show < ApiAction
  action do
    todo = TodoQuery.new.find(id)
    json Todos::ShowSerializer.new(todo)
  end
end
