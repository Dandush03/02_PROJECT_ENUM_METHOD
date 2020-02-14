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

  def my_all?
    bool_item = true
    my_each do |item|
      bool_item = false unless yield(item)
    end
    bool_item
  end

  def my_any?
    bool_item = false
    my_each do |item|
      bool_item = true if yield(item)
    end
    bool_item
  end

  def my_none?
    bool_item = true
    my_each do |item|
      bool_item = false if yield(item)
    end
    bool_item
  end

  def my_count
    counter = 0
    my_each do |item|
      counter += 1 if yield(item)
    end
    counter
  end

  def my_map(is_proc = nil)
    new_items = []
    my_each do |item|
      is_proc ? new_items.push(is_proc.call(item)) : new_items << yield(item)
    end
    new_items
  end

  def my_inject(temp_option = nil)
    new_items = temp_option || shift
    my_each do |item|
      new_items = yield(new_items, item)
    end
    new_items
  end
end

def multiply_els(array_num)
  array_num.my_inject { |results, number| results * number }
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
puts ' '
puts ' ####################################### '
puts ' ############### my_all ################ '
puts ' ####################################### '
puts ' '
temp = temp_array.all? { |word| word.length >= 3 }
puts temp
puts ' '
temp = temp_array.my_all? { |word| word.length >= 3 }
puts temp
puts ' '
puts ' ####################################### '
puts ' ############## my_any? ################ '
puts ' ####################################### '
puts ' '
temp = temp_array.any? { |word| word.length >= 7 }
puts temp
puts ' '
temp = temp_array.my_any? { |word| word.length >= 7 }
puts temp
puts ' '
puts ' ####################################### '
puts ' ############## my_none? ############### '
puts ' ####################################### '
puts ' '
temp = temp_array.none? { |word| word.length >= 7 }
puts temp
puts ' '
temp = temp_array.my_none? { |word| word.length >= 7 }
puts temp
puts ' '
puts ' ####################################### '
puts ' ############## my_count ############### '
puts ' ####################################### '
puts ' '
temp = temp_number.count { |num| (num % 3).zero? }
puts temp
puts ' '
temp = temp_number.my_count { |num| (num % 3).zero? }
puts temp
puts ' '
puts ' ####################################### '
puts ' ############### my_map ################ '
puts ' ####################################### '
puts ' '
temp = temp_number.map { |num| num * 2 }
puts temp
puts ' '
temp = temp_number.my_map { |num| num * 2 }
puts temp
puts ' '
puts ' ####################################### '
puts ' ############# my_inject ############### '
puts ' ####################################### '
puts ' '
temp = temp_number.inject(0) { |results, elements| results + elements }
puts temp
puts ' '
temp = temp_number.my_inject(0) { |results, elements| results + elements }
puts temp
puts ' '
puts ' ####################################### '
puts ' ############ multiply_els ############# '
puts ' ####################################### '
puts ' '
temp = multiply_els(temp_number)
puts temp
puts ' '
puts ' ####################################### '
puts ' ########### proc challenge ############ '
puts ' ####################################### '
puts ' '
temp = proc { |number| number * 4 }
puts temp_number.my_map(temp)
puts ' '
temp = temp_number.my_map { |number| number * 2 }
puts temp
