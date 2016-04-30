module Geo
  module ActiveRecord
    extend ActiveSupport::Concern

    module ClassMethods

      private

      def datasource
        Geo::DataSource.instance.doc
      end

      def has_many(resources)
        define_method resources.to_sym do
          ("Geo::" + resources.to_s.singularize.camelize).constantize.where(parent: self)
        end
      end

      def attrs(*args)
        attr_accessor(*args)

        define_method :initialize do |options|
          args.each do |attr|
            instance_variable_set("@#{attr}", options[attr])
          end
        end
      end
    end

  end
end
