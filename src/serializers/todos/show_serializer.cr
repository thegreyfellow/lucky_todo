class Todos::ShowSerializer < Lucky::Serializer
  def initialize(@todo : Todo)
  end

  def render
    {
      todo: {
        id: @todo.id,
        title: @todo.title,
        description: @todo.description
      }
    }
  end
end
