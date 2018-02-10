class Todos::Create < ApiAction
  action do
    TodoForm.create(params) do |form, todo|
      if todo
        json({ message: "Todo created successfully" }, status: 201)
      else
        json({ message: "Todo was not created successfully" }, status: 422)
      end
    end
  end
end
