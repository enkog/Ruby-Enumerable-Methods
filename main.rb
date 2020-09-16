module Enumerable
  # my_each method
  def my_each
    arr=self.to_a
    return arr.to_enum unless block_given?
    i = 0
    while i < arr.size
      yield arr[i]
      i += 1
    end
  end

  # my_each_with_index method
  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  # my_select method
  def my_select
    return to_enum unless block_given?

    arr = []
    to_a.my_each { |i| arr << i if yield i }
    arr
  end

  # my_all method
  def my_all?(args = nil)
    if block_given?
      my_each { |i| return false unless yield i }
      return true
    elsif args.nil?
      my_each { |i| return false if i.nil? }
    elsif !args.nil? && args.is_a?(Class)
      my_each { |i| return false unless i.class != args }
    elsif !args.nil? && args.class == Regexp
      my_each { |i| return false unless args.match(i) }
    else
      my_each { |i| return false if i != args }
    end
    true
  end

  # my_any method
  def my_any?(args = nil)
    if block_given?
      my_each { |i| return true if yield i }
      return false
    elsif args.nil?
      my_each { |i| return true if i }
    elsif !args.nil? && args.is_a?(Class)
      my_each { |i| return true if i.class != args }
    elsif !args.nil? && args.class == Regexp
      my_each { |i| return true if args.match(i) }
    else
      my_each { |i| return true if i != args }
    end
    false
  end

  # my_none method
  def my_none?(args = nil)
    if block_given?
      my_each { |i| return false if yield i }
      true
    else
      !my_any?(args)
    end
  end

  # my_count method
  def my_count(args = nil)
    count = 0
    if args.nil?
      block_given? ? to_a.my_each { |i| count += 1 if yield(i) } : count = to_a.length
    else
      to_a.my_each { |i| count += 1 if args == i }
    end
    count
  end

  # my_map method
  def my_map(proc = nil)
    return to_enum unless block_given? || proc

    arr = []
    if proc
      my_each { |i| arr << proc.call(i) }
    else
      my_each { |i| arr << yield(i) }
    end
    arr
  end

  # my_inject method
  def my_inject(acc = 0)
    result=0
    arr=self
    arr=arr.to_a
    if acc.is_a?(Symbol)
      case acc
        when :+
           arr.my_each {|a| result=result+a}
           return result
          when :-
            arr.my_each {|a| result=result-a}
            return result
          when :*
            result=1
            arr.my_each {|a| result=result*a}
            return result
      end
    else
      arr.my_each { |a| acc = yield(acc, a) }
      acc
    end
  end
end

# multiply_els method
def multiply_els(arr)
  arr.my_inject { |acc, b| acc * b }
end
