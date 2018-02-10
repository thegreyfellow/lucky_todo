class CreateTodos::V20180208102629 < LuckyMigrator::Migration::V1
  def migrate
    create :todos do
     add title : String
     add description : String?

     add_index :title
    end

    # Run custom SQL with execute
    #
    # execute "CREATE UNIQUE INDEX things_title_index ON things (title);"
  end

  def rollback
    drop :todos
  end
end
