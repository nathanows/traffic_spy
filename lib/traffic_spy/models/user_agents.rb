module TrafficSpy
  class UserAgent
    attr_reader :id, :agent

    def initialize(attributes)
      @id       = attributes[:id]
      @agent    = attributes[:agent]
      @browser  = attributes[:browser]
      @os       = attributes[:os]
    end

    def self.table
      DB.from(:user_agents)
    end

    def self.add_new(attributes)
      create(attributes) if find_user_agent(attributes[:userAgent]).nil?
      find_user_agent(attributes[:userAgent])
    end

    def self.create(attributes)
      table.insert(
        :id   => next_id,
        :agent  => attributes[:userAgent],
        :browser => attributes[:userAgent].to_s.match(/(^[\w.-\/]+) ([\W][\w]+[\W] [\w\d ]+[\W]) ([\w\/.]+) ([\W][\w, ]+[\W]) ([\w\/. ]+$)/)[4],
        :os => attributes[:userAgent].to_s.match(/(^[\w.-\/]+) ([\W][\w]+[\W] [\w\d ]+[\W]) ([\w\/.]+) ([\W][\w, ]+[\W]) ([\w\/. ]+$)/)[2]
        )
    end

    def self.next_id
      table.count + 1
    end

    def self.find_user_agent(agent)
      row = table.where(agent: agent).first
      UserAgent.new(row) if row
    end

    def self.parse_browser(agent)
      DB.fetch(
      "SELECT count(p.user_agent_id), u.browser
      FROM public.user_agents u
      INNER JOIN public.payloads p
      ON u.id = p.user_agent_id
      WHERE p.source = '#{agent}'
      GROUP BY u.browser
      ORDER BY count(p.user_agent_id) DESC;"
      ).all
    end

    def self.parse_os(agent)
      DB.fetch(
      "SELECT count(p.user_agent_id), u.os
      FROM public.user_agents u
      INNER JOIN public.payloads p
      ON u.id = p.user_agent_id
      WHERE p.source = '#{agent}'
      GROUP BY u.os
      ORDER BY count(p.user_agent_id) DESC;"
      ).all
    end

  end
end
