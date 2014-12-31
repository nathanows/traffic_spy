module TrafficSpy
  class Payload

    def self.invalid?(payload)
      payload[:url] &&
      payload[:requestedAt] &&
      payload[:respondedIn] &&
      payload[:referredBy] &&
      payload[:requestType] &&
      payload[:parameters] &&
      payload[:eventName] &&
      payload[:userAgent] &&
      payload[:resolutionWidth] &&
      payload[:resolutionHeight] &&
      payload[:ip]
    end

    def self.table
      DB.from(:payloads)
    end

    def self.create(payload, source)
      to_load = prep(payload)
      begin
        table.insert(
          :id            => next_id,
          :source        => source,
          :url_id        => to_load["url_id"],
          :requested_at  => to_load["requested_at"],
          :responded_in  => to_load["responded_in"],
          :referral_id   => to_load["referral_id"],
          :request_type  => to_load["request_type"],
          :parameters    => to_load["parameters"],
          :event_id      => to_load["event_id"],
          :user_agent_id => to_load["user_agent_id"],
          :resolution_id => to_load["resolution_id"],
          :ip            => to_load["ip"]
        )
      rescue Sequel::ForeignKeyConstraintViolation
        false
      rescue Sequel::UniqueConstraintViolation
        false
      end
    end

    def self.prep(payload)
      new = Hash.new()
      new["url_id"]        = URL.add_new(url_hash(payload, :url, :rootUrl)).id
      new["requested_at"]  = payload[:requestedAt]
      new["responded_in"]  = payload[:respondedIn]
      new["referral_id"]   = Referral.add_new(payload_hash(payload, :referredBy)).id
      new["request_type"]  = payload[:requestType]
      new["parameters"]    = payload[:parameters]
      new["event_id"]      = Event.add_new(payload_hash(payload, :eventName)).id
      new["user_agent_id"] = UserAgent.add_new(payload_hash(payload, :userAgent)).id
      new["resolution_id"] = Resolution.add_new(resolution_hash(payload, :resolutionWidth, :resolutionHeight)).id
      new["ip"]            = payload[:ip]
      new
    end

    def self.next_id
      table.count + 1
    end

    def self.payload_hash(payload, key)
      payload.select {|k,v| k == key}
    end

    def self.resolution_hash(payload, width, height)
      width = payload_hash(payload, width)
      height = payload_hash(payload, height)
      new = width.merge(height)
      new
    end

    def self.url_hash(payload, key_p, key_r)
      orig = payload_hash(payload, key_p)
      orig[key_r] = orig[key_p]
      orig
    end

    #attr_reader :id, :url

    #def initialize(attributes)
      #@id      = attributes[:id]
      #@url     = attributes[:url]
    #end

    #def self.table
      #DB.from(:payloads)
    #end

    #def self.create(attributes)
      #table.insert(
        #:id   => next_id,
        #:url  => attributes[:rootUrl]
      #)
    #end

    #def self.find_url(url)
      #row = table.where(url: url).first
      #URL.new(row) if row
    #end

  end
end
