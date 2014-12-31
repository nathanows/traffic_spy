module TrafficSpy
  class Referral
    attr_reader :id, :referral

    def initialize(attributes)
      @id      = attributes[:id]
      @referral     = attributes[:referral]
    end

    def self.table
      DB.from(:referrals)
    end

    def self.add_new(attributes)
      create(attributes) if find_referral(attributes[:referredBy]).nil?
      find_referral(attributes[:referredBy])
    end

    def self.create(attributes)
      table.insert(
        :id   => next_id,
        :referral  => attributes[:referredBy]
      )
    end

    def self.next_id
      table.count + 1
    end

    def self.find_referral(referral)
      row = table.where(referral: referral).first
      Referral.new(row) if row
    end

  end
end
