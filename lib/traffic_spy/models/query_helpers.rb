module TrafficSpy
  module QueryHelper
    def self.longest_response_time(identifier, url)
      url_id = URL.find_url(url).id
      DB.fetch(
        "SELECT max(responded_in)
        FROM payloads
        WHERE source = '#{identifier}'
        AND url_id = #{url_id}"
      ).first[:max]
    end

    def self.shortest_response_time(identifier, url)
      url_id = URL.find_url(url).id
      DB.fetch(
        "SELECT min(responded_in)
        FROM payloads
        WHERE source = '#{identifier}'
        AND url_id = #{url_id}"
      ).first[:min]
    end

    def self.average_response_time(identifier, url)
      url_id = URL.find_url(url).id
      DB.fetch(
        "SELECT avg(responded_in)
        FROM payloads
        WHERE source = '#{identifier}'
        AND url_id = #{url_id}"
      ).first[:avg].to_i
    end

    def self.which_http_verbs(identifier, url)
      url_id = URL.find_url(url).id
      DB.fetch(
        "SELECT request_type
        FROM payloads
        WHERE source = '#{identifier}'
        AND url_id = #{url_id}
        GROUP BY request_type"
      ).map { |row| row[:request_type] }.join(", ")
    end

    def self.popular_referrers(identifier, url)
      url_id = URL.find_url(url).id
      DB.fetch(
        "SELECT r.referral, count(p.referral_id)
        FROM payloads p
        INNER JOIN referrals r
        ON p.referral_id = r.id
        WHERE source = '#{identifier}'
        AND url_id = #{url_id}
        GROUP BY r.referral
        ORDER BY count DESC;"
      ).map { |row| row[:referral] }.join(", ")
    end

    def self.popular_user_agents(identifier, url)
      url_id = URL.find_url(url).id
      DB.fetch(
        "SELECT u.agent, count(p.user_agent_id)
        FROM payloads p
        INNER JOIN user_agents u
        ON p.user_agent_id = u.id
        WHERE source = '#{identifier}'
        AND url_id = #{url_id}
        GROUP BY u.agent
        ORDER BY count DESC;"
      ).map { |row| row[:agent] }.join(", ")
    end
  end
end
