module Geo
  class Country
    include Geo::ActiveRecord

    attrs :code, :name, :parent_id, :province_search_key

    has_many :provinces

    def search_key
      "#{self.class.search_key}[Code='#{self.code}']"
    end

    class << self
      def search_key
        "Location/CountryRegion"
      end

      def find(code)
        search("#{search_key}[Code='#{code}']").first
      end

      def where(options = {})
        all.select { |item| Array(options[:code]).include?(item.attr('Code')) }
      end

      def all
        search(search_key)
      end

      def first
        all.first
      end

      def last
        all.last
      end

      private
      def search(q)
        datasource.search(q).inject(Geo::Array.new([])) do |sum, item|
          key = item.elements.size == 1 && item.elements[0].attr("Name").blank? ? "State/City" : "State"
          sum << new(code: item["Code"], name: item["Name"], parent_id: "Geo", province_search_key: key) if item.is_a?(Nokogiri::XML::Element)
        end
      end
    end
  end
end
