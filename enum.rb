module Enumerable
  def my_each
    counter = 0
    until counter == self.length
      yield self[counter]
      counter += 1
    end
    self
  end
  
  def my_each_with_index
    counter = 0
    until counter == self.length
      yield self[counter],counter
      counter += 1
    end
    self
  end
  
  
  def my_select
  returning_array = []
    self.my_each do |value|
      returning_array << value if yield(value)
    end
  returning_array
  end
  
  def my_all?
    self.my_each do |value|
      return false if yield(value) == false
    end
    true
  end
  
  
  def my_any?
    self.my_each do |value|
      return true if yield(value)
    end
    
    false
  end
  
  def my_none?
    self.my_each do |value|
      return false if yield(value)
    end
    
    true
  end
  
  def my_count(arg=nil)
    if arg
			self.my_select { |i| i == arg }.size
		elsif block_given?
			self.my_select { |i| yield(i) }.size
		else
			self.size
		end
  end
  
  def my_map (proc = nil)
    temp_array = self.to_a
    
    if proc && block_given?
      temp_array.my_each_with_index do |value, index|
        temp_array[index] = yield(proc.call(value))
      end
    elsif proc
      temp_array.my_each_with_index do |value, index|
        temp_array[index] = proc.call(value)
      end
    end
    
    temp_array
  end
  
  def my_inject(total = 0)
    self.my_each do |value|
      total = yield(total, value)
    end
    
    total
  end
end

def multiply_els (input_array)
  input_array.my_inject(1) {|product, n| product * n}
end

example_proc = Proc.new do |value|
  value ** 2
end

puts ([1,3,5].my_map)