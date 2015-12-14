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
end


puts [2,4,6,8].my_all? {|num| num % 2 == 0}