Sequel.migration do
  change do
    create_table(:user_agents) do
      primary_key   :id
      String        :agent
    end
  end
end
