class Todos::Delete < ApiAction
  action do
    if TodoQuery.new.find(id).delete
      json({ message: "Todo deleted successfully" }, 201)
    else
      json({ message: "Todo was not deleted successfully" }, 422)
    end
  end
end
