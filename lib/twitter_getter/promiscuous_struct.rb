module PromiscuousStruct
  attr_reader :attributes
  
  def initialize(h)
    @attributes = h
  end
  
  def get_val(a)
    val = @attributes[a] || @attributes[a.to_s] || @attributes[a.to_sym]
    if val.is_a?(Hash)
      self.class.new(val)
    else
      val
    end
  end
  
  def [](a)
   get_val(a)
  end
  
  # an existing but depricated method we need to overide
  def id
    get_val(:id)
  end
  
  def method_missing(m)
    if val = get_val(m)
      return val
    elsif @attributes.respond_to?(m)
      return @attributes.send(m)
    else
      nil
    end
  end
end