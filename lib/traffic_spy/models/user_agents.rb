module TrafficSpy
  class UserAgent
    attr_reader :id, :agent

    def initialize(attributes)
      @id      = attributes[:id]
      @agent     = attributes[:agent]
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
        :agent  => attributes[:userAgent]
      )
    end

    def self.next_id
      table.count + 1
    end

    def self.find_user_agent(agent)
      row = table.where(agent: agent).first
      UserAgent.new(row) if row
    end

  end
end
