module TrafficSpy
  class Event
    attr_reader :id, :name

    def initialize(attributes)
      @id       = attributes[:id]
      @name     = attributes[:name]
    end

    def self.table
      DB.from(:events)
    end

    def self.add_new(attributes)
      create(attributes) if find_event(attributes[:eventName]).nil?
      find_event(attributes[:eventName])
    end

    def self.create(attributes)
      table.insert(
        :id    => next_id,
        :name  => attributes[:eventName]
      )
    end

    def self.next_id
      table.count + 1
    end

    def self.find_event(name)
      row = table.where(name: name).first
      Event.new(row) if row
    end
  end
end
