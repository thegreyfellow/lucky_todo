class Todo < BaseModel
  table :todos do
    column title : String
    column description : String?
  end
end
