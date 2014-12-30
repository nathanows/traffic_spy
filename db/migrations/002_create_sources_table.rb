Sequel.migration do
  change do
    create_table(:sources) do
      String        :identifier, :unique => true, :primary_key => true
      foreign_key   :url_id, :urls
    end
  end
end
