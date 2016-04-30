module Geo
  class Province
    include Geo::ActiveRecord

    attrs :code, :name, :parent_id, :country

    has_many :cities

    def search_key
      "#{country.search_key}/#{country.province_search_key}[Code='#{self.code}']"
    end

    def self.where(options = {})
      parent = options[:parent]
      datasource.search("#{parent.search_key}/#{parent.province_search_key}").inject(Geo::Array.new([])) do |sum, item|
        sum << new(code: item["Code"], name: item["Name"], parent_id: parent.code, country: parent) if item.is_a?(Nokogiri::XML::Element)
      end
    end
  end
end
