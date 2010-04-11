class String    
  def /(o)
    File.join(self, o.to_s)
  end
end

class Object
  def to_openstruct
    self
  end
end

class Array
  def to_openstruct
    map{ |el| el.to_openstruct }
  end
end

class Hash
  def to_openstruct
    mapped = {}
    each{ |key,value| mapped[key] = value.to_openstruct }
    OpenStruct.new(mapped)
  end
end

class TrueClass
  def and(o)
    self and o
  end
end

class FalseClass
  def and(o)
    self and o
  end
end
