module TrafficSpy
  class URL
    attr_reader :id, :url

    def initialize(attributes)
      @id      = attributes[:id]
      @url     = attributes[:url]
    end

    def self.table
      DB.from(:urls)
    end

    def self.add_new(attributes)
      create(attributes) if find_url(attributes[:rootUrl]).nil?
      find_url(attributes[:rootUrl])
    end

    def self.create(attributes)
      table.insert(
        :id   => next_id,
        :url  => attributes[:rootUrl]
      )
    end

    def self.next_id
      table.count + 1
    end

    def self.find_url(url)
      row = table.where(url: url).first
      URL.new(row) if row
    end
  end
end
