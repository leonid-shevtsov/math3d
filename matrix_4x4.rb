class Matrix4x4
  # Matrix4x4.new - unit matrix
  # Matrix4x4.new 2 - diagonal matrix
  # Matrix4x4.new m00, m10, m20, m30, m11, ... m33 - direct by-element constructor
  # Matrix4x4.new [[m00,m10,m20,m30],[m11,m21,...],[...],[...]] - constructor from array
  # Matrix4x4.new [m00, m10, ... m33] - another constructor from array
  def initialize *args
    if args.empty?
      data = [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]
    elsif args.length==1 
      if args[0].is_a?(Numeric)
        k = args[0]
        data = [k,0,0,0,0,k,0,0,0,0,k,0,0,0,0,k]
      elsif args[0].is_a?(Array)
        data = args[0].flatten
        raise TypeError.new unless data.length==16
      else
        raise TypeError.new
      end
    elsif args.length==16
      data = args
    else
      raise TypeError.new
    end
    @elements = data.map {|el| el.to_f}
  end

  def at i,j
    raise TypeError.new unless i.is_a?(Fixnum) and j.is_a?(Fixnum)
    @elements[i*4+j]
  end

  def assign i,j,value
    raise TypeError.new unless i.is_a?(Fixnum) and j.is_a?(Fixnum)
    @elements[i*4+j]
  end

  # pos belongs to 0..15
  def [] pos
    raise TypeError.new unless pos.is_a? Fixnum
    @elements[pos]
  end

  def []= pos, value
    raise TypeError.new unless pos.is_a? Fixnum
    @elements[pos] = value
  end
  
  #TODO probably this returns reference to the same array that's inside the matrix
  def to_a
    @elements
  end

  # 1. Multiplication by scalar
  # 2. Product of two affine matrices
  #    - Use Matrix4x4#multiply if the matrices aren't affine
  def * b
    if b.is_a? Numeric
      Matrix4x4.new @elements.map{|a| a*b}
    elsif b.is_a? Matrix4x4
      #TODO
    else
      raise TypeError.new
    end
  end

  # Multiplication of two generic matrices (non-affine)
  def multiply b
  end

  # Application of the matrix to a vector or a point
  def apply v
  end

  # Application of the matrix to a vector or a point, using the W element (use this for a projection matrix)
  def apply_w v
  end

  # Transposes the matrix and returns the result
  def transpose
    m = Matrix4x4.new @elements
    m.transpose!
    m
  end

  # Transposes the matrix
  def transpose!
    @elements[1], @elements[4] = @elements[4], @elements[1]
    @elements[2], @elements[8] = @elements[8], @elements[2]
    @elements[3], @elements[12] = @elements[12], @elements[3]
    @elements[6], @elements[9] = @elements[9], @elements[6]
    @elements[7], @elements[13] = @elements[13], @elements[7]
    @elements[11], @elements[14] = @elements[14], @elements[11]
    nil
  end

#Factories
  def self.translate v
  end

  def self.scale v
  end

  def self.rotate_x a
  end

  def self.rotate_y a
  end

  def self.rotate_z a
  end

  #TODO implement rotation around an arbitrary axis
  def self.rotate
  end
end
