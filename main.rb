module Enumerable
  def my_each
    if is_a? Range
      min = self.min
      max = self.max

      while min <= max
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

  def my_each_with_index
    if is_a? Range
      min = self.min
      max = self.max
      index = 0
      while min <= max
        yield(min, index)
        min += 1
        index += 1
      end

    else
      min = 0
      max = length

      while min < max
        yield(self[min], min)
        min += 1
      end

    end
  end

  def my_select
    items = []
    my_each do |item|
      items << item if yield(item)
    end
    items
  end
end
temp_array = %w[cat dog fish turtle]
range = (2..4)
temp_number = [1, 2, 3, 4, 5, 6]
puts ' '
puts ' ####################################### '
puts ' ############### my_each ############### '
puts ' ####################################### '
puts ' '
puts ' ############# Range Type ############## '
range.each { |n| puts n }
puts ' '
range.my_each { |n| puts n }
puts ' '
puts ' ############# Array Type ############## '
temp_array.each { |n| puts n }
puts ' '
temp_array.my_each { |n| puts n }
puts ' '
puts ' ####################################### '
puts ' ######### my_each_with_index ########## '
puts ' ####################################### '
puts ' '
puts ' ############# Range Type ############## '
range.each_with_index { |n, m| puts "#{n}:#{m}" }
puts ' '
range.my_each_with_index { |n, m| puts "#{n}:#{m}" }
puts ' '
puts ' ############# Array Type ############## '
temp_array.each_with_index { |n, m| puts "#{n}:#{m}" }
puts ' '
temp_array.my_each_with_index { |n, m| puts "#{n}:#{m}" }
puts ' '
puts ' ####################################### '
puts ' ############## my_select ############## '
puts ' ####################################### '
puts ' '
puts temp_number.select(&:even?)
puts ' '
puts temp_number.my_select(&:even?)
