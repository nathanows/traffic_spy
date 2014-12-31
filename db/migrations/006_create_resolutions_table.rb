Sequel.migration do
  change do
    create_table(:resolutions) do
      primary_key   :id
      Integer       :width
      Integer       :height
    end
  end
end
