module TrafficSpy
  class Source
    attr_reader :identifier, :url_id

    def initialize(attributes)
      @identifier = attributes[:identifier]
      @url_id     = attributes[:url_id]
    end

    def self.table
      DB.from(:sources)
    end

    def self.create(attributes, url)
      table.insert(
        :identifier => attributes[:identifier]
        :url_id => url
        )
    end
  end
end