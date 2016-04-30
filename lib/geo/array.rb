class Geo::Array < Array
  class ConditionBuilder
    def initialize(options = {})
      @conditions = {}
      @options = options

      set_conditions
    end

    def set_conditions
      name = Array(@options[:name])
      code = Array(@options[:code])

      @conditions.merge!(name: name) if name.present?
      @conditions.merge!(code: code) if code.present?
    end

    def generate
      condition = "true "
      @conditions.each do |key, value|
        condition += "&& #{value}.include?(item.#{key}) "
      end

      ->(item) { eval(condition) }
    end
  end

  def find(code)
    where(code: code).first
  end


  def where(options = {})
    cb = ConditionBuilder.new(options)

    self.class.new(self.select &cb.generate)
  end

end
