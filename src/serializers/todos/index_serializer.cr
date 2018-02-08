class Todos::IndexSerializer < Lucky::Serializer
  def initialize
  end

  def render
    {todos: todos}
  end

  private def todos
    TodoQuery.new.each do |todo|
      Todos::ShowSerializer.new(todo)
    end
  end
end
