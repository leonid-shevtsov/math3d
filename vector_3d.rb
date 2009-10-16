require 'vector_2d'

#TODO scalar * vector operations are not yet supported
class Vector3d
  attr_accessor :x, :y, :z

  # Vector3d.new 1,2,3
  # Vector3d.new [1,2,3]
  # Vector3d.new {:x => 1, :y => 2, :z => 3}
  # Vector3d.new 1
  def initialize value, y=nil, z=nil
    if value.is_a?(Numeric) and y.is_a?(Numeric) and z.is_a?(Numeric)
      @x = value.to_f
      @y = y.to_f
      @z = z.to_f
    elsif value.is_a? Array and y.nil? and z.nil?
      @x = value[0].to_f
      @y = value[1].to_f
      @z = value[2].to_f
    elsif value.is_a? Hash and y.nil? and z.nil?
      @x = value[:x].to_f
      @y = value[:y].to_f
      @z = value[:z].to_f
    elsif value.is_a? Numeric and y.nil? and z.nil?
      @x = @y = @z = value.to_f
    elsif value.is_a? Vector2d
      @x = value.x
      @y = value.y
      @z = 0.0
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
    "{#{@x}, #{@y}, #{@z}}"
  end

  # Conversion to array
  def to_a
    [@x, @y, @z]
  end

  # Conversion to a point
  def to_p
    Point3d.new @x, @y, @z
  end

  def empty?
    @x==0.0 and @y==0.0 and @z==0.0
  end
  
  # Equality
  def == b
    b.is_a?(Vector3d) and @x==b.x and @y==b.y and @z==b.z
  end
 
  # Length (norm)
  def norm
    Math.sqrt(norm_sq)
  end
  alias_method :length, :norm

  # Length, squared
  def norm_sq
    @x*@x + @y*@y + @z*@z
  end

  # Vector product (or multiplication by scalar)
  def * b
    if b.is_a? Vector3d
      Vector3d.new @y*b.z-@z*b.y, @z*b.x-@x*b.z, @x*b.y-@y*b.x
    elsif b.is_a? Numeric
      Vector3d.new @x*b, @y*b, @z*b
    else
      raise TypeError.new
    end
  end

  # Vector addition
  def + b
    raise TypeError.new unless b.is_a? Vector3d
    Vector3d.new @x+b.x, @y+b.y, @z+b.z
  end

  # Vector subtraction
  def - b
    raise TypeError.new unless b.is_a? Vector3d
    Vector3d.new @x-b.x, @y-b.y, @z-b.z
  end

  # Negation
  def -@
    Vector3d.new(-@x, -@y, -@z)
  end

  # Divide by scalar
  def / b
    raise TypeError.new unless b.is_a? Numeric
    Vector3d.new @x/b, @y/b, @z/b
  end  

  # Scalar product
  def & b
    @x*b.x+@y*b.y+@z*b.z
  end

  # Returns a vector with the same direction and unit length
  def normalize
    self*(1.0/norm)
  end

  def normalize!
    k = (1.0/norm)
    @x *= k
    @y *= k
    @z *= k
    nil
  end

  # Returns a random vector with components in [0..1] range 
  def self.random
    Vector3d.new rand, rand, rand
  end

  def self.random_sphere_delta radius
    #TODO
  end
  
  def self.random_cube_delta side
    #TODO
  end
end

#TODO is this ok?
#TODO disable methods that are not applicable to points. What are they?
class Point3d < Vector3d
  def inspect
    "Point3d: #{self.to_s}" 
  end
end

class Array
  # Convenience method 
  def to_vector3d
    Vector3d.new(self[0],self[1],self[2])
  end
end

class Vector2d
  # Convenience method
  def to_3d
    Vector3d.new(@x, @y, 0)
  end
end

p = Point3d.new(1,2,3)

puts p.inspect
