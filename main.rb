module Enumerable
  def my_each
    if self.is_a? Range then
      min = self.min
      max = self.max
      
      while min < max do
        puts min
        min += 1
      
      end
    else
      min = 0
      max = length
      while min < max
        yield(self[min])
        min += 1
      end
    end
  end
end
temp_array = %w[cat dog fish turtle]
range = (2..4)
#puts range.each { |n| puts n }
puts temp_array.my_each { |n| puts n }
puts range.my_each { |n| puts n }
