#TODO scalar * vector operations are not yet supported
class Vector2d
  attr_accessor :x, :y

  # Vector2d.new 1,2
  # Vector2d.new [1,2]
  # Vector2d.new {:x => 1, :y => 2}
  # Vector2d.new 1
  def initialize value, y=nil
    if value.is_a?(Numeric) and y.is_a?(Numeric)
      @x = value.to_f
      @y = y.to_f
    elsif value.is_a? Array and y.nil?
      @x = value[0].to_f
      @y = value[1].to_f
    elsif value.is_a? Hash and y.nil?
      @x = value[:x].to_f
      @y = value[:y].to_f
    elsif value.is_a? Numeric and y.nil?
      @x = @y = value.to_f
    else
      raise TypeError.new
    end
  end

  # Inspect
  def inspect
    "Vector3d: #{self.to_s}"
  end

  # Conversion to string
  def to_s
    "{#{@x}, #{@y}}}"
  end

  # Conversion to array
  def to_a
    [@x, @y]
  end

  def empty?
    @x==0.0 and @y==0.0
  end

  # Equality
  def == b
    b.is_a?(Vector2d) and @x==b.x and @y==b.y
  end

  # Length (norm)
  def norm
    Math.sqrt(norm_sq)
  end
  alias_method :length, :norm

  # Length, squared
  def norm_sq
    @x*@x + @y*@y
  end

  # Vector product (or multiplication by scalar)
  def * b
    if b.is_a? Vector2d
      @x*b.y-@y*b.x;
    elsif b.is_a? Numeric
      Vector2d.new @x*b, @y*b
    else
      raise TypeError.new
    end
  end

  # Vector addition
  def + b
    raise TypeError.new unless b.is_a? Vector2d
    Vector2d.new @x+b.x, @y+b.y
  end

  # Vector subtraction
  def - b
    raise TypeError.new unless b.is_a? Vector2d
    Vector2d.new @x-b.x, @y-b.y
  end

  # Negation
  def -@
    Vector2d.new(-@x, -@y)
  end

  # Divide by scalar
  def / b
    raise TypeError.new unless b.is_a? Numeric
    Vector2d.new @x/b, @y/b
  end  

  # Scalar product
  def & b
    @x*b.x+@y*b.y
  end

  # Returns a vector with the same direction and unit length
  def normalize
    self*(1.0/norm)
  end

  def normalize!
    k = (1.0/norm)
    @x *= k
    @y *= k
    nil
  end

  # Returns a random vector with components in [0..1] range 
  def self.random
    Vector2d.new rand, rand
  end

  def self.random_circle_delta radius
    #TODO
  end
  
  def self.random_square_delta side
    #TODO
  end
end

class Point2d < Vector2d
end

class Array
  # Convenience method 
  def to_vector2d
    Vector2d.new(self[0],self[1])
  end
end
