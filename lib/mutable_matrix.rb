require 'matrix'
module MutableMatrix
  refine Matrix do
    def []=(i, j, x)
      @rows[i][j] = x
    end
    def to_readable
      i = 0
      self.each do |number|
        print number.to_s + " "
        i+= 1
        if i == self.column_size
          print "\n"
          i = 0
        end
      end
    end
  end
end

