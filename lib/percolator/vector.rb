class Percolator
  class Vector
    attr_accessor :x, :y

    def initialize(x = 0, y = 0)
      @x = x
      @y = y
    end

    class << self
      # Adds two vectors and returns the product
      def add(v1, v2)
        Vector.new(v1.x + v2.x, v1.y + v2.y)
      end

      # Subtracts v2 from v1 and returns the product
      def sub(v1, v2)
        Vector.new(v1.x - v2.x, v1.y - v2.y)
      end

      # Projects one vector (v1) onto another (v2)
      def project(v1, v2)
        v1.clone.scale(v1.dot(v2) / v1.magSq)
      end
    end

    # Sets the components of this vector
    def set(x, y)
      @x = x
      @y = y
      self
    end

    # Add a vector to this one
    def add(v)
      @x += v.x
      @y += v.y
      self
    end

    # Subtracts a vector from this one
    def sub(v)
      @x -= v.x
      @y -= v.y
      self
    end

    # Scales this vector by a value
    def scale(f)
      @x *= f
      @y *= f
      self
    end

    # Normalises the vector, making it a unit vector (of length 1)
    def norm
      m = mag
      @x /= m
      @y /= m
      self
    end

    # Limits the vector length to a given amount
    def limit(l)
      mSq = @x*@x + @y*@y
      if mSq > l*l
        m = Math.sqrt(mSq)
        @x /= m
        @y /= m
        @x *= l
        @y *= l
      end
      self
    end

    # more memory efficient way of `v1 = v2.dup`
    def become(v)
      @x = v.x
      @y = v.y
      self
    end

    # Computes the dot product between vectors
    def dot(v)
      @x * v.x + @y * v.y
    end

    # Computes the cross product between vectors
    def cross(v)
      (@x * v.y) - (@y * v.x)
    end

    # Computes the magnitude (length)
    def mag
      Math.sqrt(@x*@x + @y*@y)
    end

    # Computes the squared magnitude (length)
    def magSq
      @x*@x + @y*@y
    end

    # Computes the distance to another vector
    def dist(v)
      dx = v.x - @x
      dy = v.y - @y
      Math.sqrt(dx*dx + dy*dy)
    end

    # Computes the squared distance to another vector
    def distSq(v)
      dx = v.x - @x
      dy = v.y - @y
      dx*dx + dy*dy
    end

    # Resets the vector to zero
    def clear
      @x = 0.0
      @y = 0.0
    end

    def to_h
      {
        x: @x,
        y: @y,
      }
    end
  end
end
