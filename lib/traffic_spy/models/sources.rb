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
      begin
        table.insert(
          :identifier => attributes[:identifier],
          :url_id => url
        )
      rescue Sequel::UniqueConstraintViolation
        return false
      end
    end

    def self.find_identifier(identifier)
      table.select(:identifier).where(identifier: identifier).first
    end

    def self.find_object(identifier)
      row = table.where(identifier: identifier).first
      Source.new(row) if row
    end
  end
end
