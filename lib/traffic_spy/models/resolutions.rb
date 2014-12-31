module TrafficSpy
  class Resolution
    attr_reader :id, :width, :height

    def initialize(attributes)
      @id         = attributes[:id]
      @width      = attributes[:width]
      @height     = attributes[:height]
    end

    def self.table
      DB.from(:resolutions)
    end

    def self.add_new(attributes)
      create(attributes) if find_resolution(attributes[:resolutionWidth], attributes[:resolutionHeight]).nil?
      find_resolution(attributes[:resolutionWidth], attributes[:resolutionHeight])
    end

    def self.create(attributes)
      table.insert(
        :id      => next_id,
        :width   => attributes[:resolutionWidth],
        :height  => attributes[:resolutionHeight]
      )
    end

    def self.next_id
      table.count + 1
    end

    def self.find_resolution(width, height)
      row = table.where(width: width).where(height: height).first
      Resolution.new(row) if row
    end
  end
end
