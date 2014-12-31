Sequel.migration do
  change do
    create_table(:payloads) do
      primary_key   :id
      foreign_key   :source, :sources, :type => String
      foreign_key   :url_id, :urls
      DateTime      :requested_at
      Integer       :responded_in
      foreign_key   :referral_id, :referrals
      String        :request_type
      String        :parameters
      foreign_key   :event_id, :events
      foreign_key   :user_agent_id, :user_agents
      foreign_key   :resolution_id, :resolutions
      String        :ip
      unique        [:source,
                     :url_id,
                     :requested_at,
                     :responded_in,
                     :referral_id,
                     :request_type,
                     :event_id,
                     :user_agent_id,
                     :resolution_id,
                     :ip]
    end
  end
end
