Sequel.migration do
  change do
    create_table(:user_agents) do
      primary_key   :id
      String        :agent
      String        :browser
      String        :os
    end
  end
end
