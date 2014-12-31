Sequel.migration do
  change do
    create_table(:referrals) do
      primary_key   :id
      String        :referral
    end
  end
end
