module Geo
  class Location
    class << self
      def countries
        Geo::Country.all
      end

      def provinces(code)
        country = country(code.to_s)
        return Geo::Array.new([]) if country.blank?

        country.provinces
      end

      def cities(country_code, pro_code)
        province = province(country_code.to_s, pro_code.to_s)
        return Geo::Array.new([]) if province.blank?

        province.cities
      end

      def regions(country_code, pro_code, city_code)
        city = city(country_code.to_s, pro_code.to_s, city_code.to_s)
        return Geo::Array.new([]) if city.blank?

        city.regions
      end

      def country(c_code)
        Geo::Country.find(c_code.to_s)
      end

      def province(c_code, s_code)
        provinces(c_code.to_s).find(s_code.to_s)
      end

      def city(country_code, p_code, city_code)
        cities(country_code.to_s, p_code.to_s).find(city_code.to_s)
      end
    end
  end
end
