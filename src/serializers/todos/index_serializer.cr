class Todos::IndexSerializer < Lucky::Serializer
  def initialize
  end

  def render
    {todos: todos}
  end

  private def todos
    TodoQuery.new.map do |todo|
      Todos::ShowSerializer.new(todo)
    end
  end
end
