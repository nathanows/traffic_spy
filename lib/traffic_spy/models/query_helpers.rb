module TrafficSpy
  module QueryHelper
    def self.min_response_time(identifier, path)
      root_url = URL.find_object(Source.find_object(identifier).url_id).url
      full_url = root_url + "/" + path.join("/")
      if URL.find_url(full_url).id.nil?
        return
      else
        url_id = URL.find_url(full_url).id
        DB.fetch(
          "SELECT max(responded_in)
          FROM payloads
          WHERE source = '#{identifier}'
          AND url_id = #{url_id}"
        )
      end
    end
  end
end
