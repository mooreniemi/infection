module ArrayTrim
  refine Array do
    def trim_by(delta)
      last = self.first
      new_array = [last]
      (1..self.length - 1).each do |i|
        if last < (1 - delta) * self[i]
          new_array << self[i]
          last = self[i]
        end
      end
      new_array
    end
  end
end

