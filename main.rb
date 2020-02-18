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
      my_each { |item| bool_item = false unless item.match(opt) }
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
      my_each { |item| bool_item = true if item.nil? || item == false }
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
      my_each { |item| bool_item = false if item.nil? || item == false }
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
