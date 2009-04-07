module PromiscuousStruct
  attr_reader :attributes
  
  def initialize(h)
    @attributes = h
  end
  
  def get_val(a)
    @attributes[a] || @attributes[a.to_s] || @attributes[a.to_sym]
  end
  
  def [](a)
   get_val(a)
  end
  
  def method_missing(m)
    if val = get_val(m)
      return val
    elsif @attributes.respond_to?(m)
      return @attributes.send(m)
    else
      super
    end
  end
end