require "geo/version"

module Geo
  class << self
    extend Forwardable

    def_delegators :location, :countries, :provinces, :cities, :regions, :country, :province, :city

    alias :states :provinces
    alias :state :province

    def location
      Geo::Location
    end
  end
end

require 'active_support/core_ext/object'
require 'active_support/concern'
require 'geo/location'
require 'geo/active_record'
require 'geo/country'
require 'geo/data_source'
require 'geo/array'
require 'geo/province'
require 'geo/city'
require 'geo/region'
require 'nokogiri'
