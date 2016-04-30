require 'singleton'

module Geo
  class DataSource
    include Singleton

    def doc
      @doc ||= Nokogiri::XML(file)
    end

    private

    def file
      read
      @file
    end

    def read
      file = File.open(File.expand_path('../loc_list.xml', __FILE__)) unless @file
      @file ||= file.read
      file.close if file
    end

  end
end
