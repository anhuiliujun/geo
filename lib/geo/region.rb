module Geo
  class Region
    include Geo::ActiveRecord

    attrs :code, :name, :parent_id, :city

    def self.search_key
      "/Region"
    end

    def self.where(options = {})
      parent = options[:parent]
      datasource.search("#{parent.search_key}#{self.search_key}").inject(Geo::Array.new([])) do |sum, item|
        sum << new(code: item["Code"], name: item["Name"], parent_id: parent.code, city: parent) if item.is_a?(Nokogiri::XML::Element)
      end
    end
  end
end
