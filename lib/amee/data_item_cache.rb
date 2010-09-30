module AMEE

  class DataItemCache

    def self.get(connection, url)
      @@cache ||= {}
      @@cache[url] ||= begin
        AMEE::Data::DrillDown.get(connection, '/data' + url).data_item_uid
      end
    end

  end
  
end
