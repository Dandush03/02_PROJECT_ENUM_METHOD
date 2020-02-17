# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable
  def my_each
    if is_a? Range
      min = self.min
      max = self.max

      while min <= max
        puts min
        min += 1
      end

    elsif block_given?
      min = 0
      max = length

      while min < max
        yield(self[min])
        min += 1
      end
      self
    else
      to_enum(:my_each)
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

    elsif block_given?
      min = 0
      max = length

      while min < max
        yield(self[min], min)
        min += 1
      end
      self
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      items = []
      my_each do |item|
        items << item if yield(item)
      end
      items
    else
      to_enum(:my_select)
    end
  end

  def my_all?(opt = nil)
    bool_item = true
    if opt.nil? && block_given?
      my_each { |item| bool_item = false unless yield(item) }
    elsif opt.is_a?(Regexp)
      my_each { |item| bool_item = false if item.match(opt) }
    elsif opt.is_a?(Module)
      my_each { |item| bool_item = false unless item.is_a?(opt) }
    else
      my_each { |item| bool_item = false if item.nil? || item == false }
    end
    bool_item
  end

  def my_any?(opt = nil)
    bool_item = false
    if opt.nil? && block_given?
      my_each { |item| bool_item = true if yield(item) }
    elsif opt.is_a?(Regexp)
      my_each { |item| bool_item = true if item.match(opt) }
    elsif opt.is_a?(Module)
      my_each { |item| bool_item = true if item.is_a?(opt) }
    else
      my_each { |item| bool_item = true unless item.nil? || item == false }
    end
    bool_item
  end

  def my_none?(opt = nil)
    bool_item = true
    if opt.nil? && block_given?
      my_each { |item| bool_item = false if yield(item) }
    elsif opt.is_a?(Regexp)
      my_each { |item| bool_item = false if item.match(opt) }
    elsif opt.is_a?(Module)
      my_each { |item| bool_item = false if item.is_a?(opt) }
    else
      my_each { |item| bool_item = false unless item.nil? || item == false }
    end
    bool_item
  end

  def my_count
    if block_given?
      counter = 0
      my_each do |item|
        counter += 1 if yield(item)
      end
    else
      counter = length
    end
    counter
  end

  def my_map(is_proc = nil)
    if block_given?
      new_items = []
      my_each do |item|
        is_proc ? new_items.push(is_proc.call(item)) : new_items << yield(item)
      end
      new_items
    else
      to_enum(:my_map)
    end
  end

  def my_inject(temp_option = nil)
    if is_a? Range
      min = self.min
      max = self.max
      new_items = temp_option || 0
      while min <= max
        new_items = yield(new_items, min)
        min += 1
      end
    else
      new_items = temp_option || shift
      my_each do |item|
        new_items = yield(new_items, item)
      end
    end
    new_items
  end
end

# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

def multiply_els(array_num)
  array_num.my_inject { |results, number| results * number }
end

puts ' '
puts 'My_All'
puts ' '
temp = %w[ant bear cat].all?(/t/) == %w[ant bear cat].my_all?(/t/)
puts temp
temp = [1, 2i, 3.14].all?(Numeric) == [1, 2i, 3.14].my_all?(Numeric)
puts temp
temp = [nil, true, 99].all? == [nil, true, 99].my_all?
puts temp
puts ' '
puts 'My_Any'
puts ' '
temp = %w[ant bear cat].my_any?(/d/) == %w[ant bear cat].any?(/d/)
puts temp
temp = [nil, true, 99].my_any?(Integer) == [nil, true, 99].any?(Integer)
puts temp
temp = [nil, true, 99].my_any? == [nil, true, 99].any?
puts temp
temp = [].my_any? == [].any?
puts temp
puts ' '
puts 'My_None'
puts ' '
temp = %w{ant bear cat}.my_none?(/d/) == %w{ant bear cat}.none?(/d/) 
puts temp
temp = [1, 3.14, 42].my_none?(Float) == [1, 3.14, 42].none?(Float)  
puts temp
temp = [].my_none? == [].none?
puts temp
temp = [nil].my_none? == [nil].none?
puts temp
temp = [nil, false].my_none? == [nil, false].none?
puts temp
