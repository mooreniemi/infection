require 'array_trim'
require 'mutable_matrix'

module PartialInfection
  refine Array do
    using ArrayTrim
    def approximate_doomed_subset_upto(target, delta = 0.25)
      n = self.length
      l = [0]
      (0..n - 1).each do |i|
        l = l + l.map {|e| e + self[i]}
        l.sort!
        l = l.trim_by(delta/(2*n))
        l.reject! {|e| e if e > target}
      end

      # we can throw out our seed value now
      l = l.reject!(&:zero?)
      l.pop # we dont need the sum we found

      # now we need to grab the original values
      l.inject([]) do |found, e|
        # we only need the first subset that works
        return found if found.reduce(0, :+) >= target

        if self.index(e)
          found << e
        else
          l.each do |seeking|
            found << self.min_by {|x| (x.to_f - seeking).abs }
          end
        end
        found
      end
    end

    using MutableMatrix
    def doomed_subset_upto(target)
      return [] if self.empty?

      all_summed = self.reject{|n| n <= 0}.reduce(0, :+)
      # we can do an early check here to make sure reaching
      # the sum is even possible, given our subset
      return false if all_summed < target

      negative_sum = self.reject{|n| n > 0}.reduce(0, :+)
      tiniest_sum = negative_sum == 0 ? self.min : negative_sum
      potential_sums = (tiniest_sum..all_summed).to_a
      array_index = -1

      table = Matrix.build(self.length + 1, potential_sums.length + 1) do |row, col|
        if col == 0 && row == 0
          " ".center(5)
        elsif col == 0
          "#{self[array_index += 1]}".center(5)
        elsif row == 0
          "#{potential_sums.shift}".center(5)
        else
          false
        end
      end

      col_header = table.row(0).to_a.map(&:to_i)

      table.each_with_index do |e, row_position, col_position|
        next if row_position == 0 || col_position == 0
        # we skip a row / column because of the col_header row / column
        num_from_subset = self[row_position - 1]
        col_label = table.column(col_position).first.to_i

        if num_from_subset == col_label
          table[row_position, col_position] = true
        elsif table[row_position - 1, col_position] == true
          table[row_position, col_position] = true
        else
          y = col_label - num_from_subset

          # we chop off the empty cell that gets coerced to 0 otherwise
          # and ignore anything that isn't in range
          next unless col_header[1..-1].include?(y)

          if table[row_position - 1, col_header.index(y)] == true
            table[row_position, col_position] = true
          end
        end
      end

      target_col_index = col_header[1..-1].index(target) + 1
      subset = []

      if table.column(target_col_index).to_a.include?(true)
        row_count = table.row_count - 1 # ignore header
        row_count.step(1,-1) do |row_index|
          next if table[row_index - 1, target_col_index] == true

          subset << (x = table[row_index, 0].to_i)
          target_col_label = table[0, target_col_index].to_i
          return subset if row_index == 1 || target_col_label - x == 0

          target_col_index = (col_header[1..-1].index(target_col_label - x) + 1)
        end
      else
        false
      end
    end
  end
end
