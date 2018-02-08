class Todos::ShowSerializer < Lucky::Serializer
  def initialize(@todo : Todo)
  end

  def render
    {
      todo: {
        title: @todo.title,
        description: @todo.description
      }
    }
  end
end
