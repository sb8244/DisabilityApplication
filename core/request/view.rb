class View
  def initialize(attributes = {})
    @attributes = attributes
  end

  def method_missing(method, *args)
    @attributes[method] unless method.to_s.include?('=')
  end
end
