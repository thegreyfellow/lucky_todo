class Todos::Update < ApiAction
  action do
    todo = TodoQuery.new.find(id)
    TodoForm.update(todo, params) do |form, todo|
      if form.valid? && form.saved?
        json({ message: "Todo updated successfully" }, status: 201)
      else
        json({ message: "Todo was not updated successfully" }, status: 422)
      end
    end
  end
end
