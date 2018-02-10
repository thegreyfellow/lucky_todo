class Todos::Index < ApiAction
  action do
    json Todos::IndexSerializer.new
  end
end
