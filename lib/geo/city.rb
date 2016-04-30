module Geo
  class City
    include Geo::ActiveRecord

    attrs :code, :name, :parent_id, :province

    has_many :regions

    def search_key
      "#{province.search_key}#{self.class.search_key}[Code='#{self.code}']"
    end

    def self.search_key
      "/City"
    end

    def self.where(options = {})
      parent = options[:parent]
      datasource.search("#{parent.search_key}#{self.search_key}").inject(Geo::Array.new([])) do |sum, item|
        sum << new(code: item["Code"], name: item["Name"], parent_id: parent.code, province: parent) if item.is_a?(Nokogiri::XML::Element)
      end
    end
  end
end
