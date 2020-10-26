module Enumerable
  # my_each method
  def my_each
    return to_enum(:each) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
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
      my_each { |i| return false if yield(i) == false }
      return true
    elsif args.nil?
      my_each { |i| return false if i.nil? || i == false }
    elsif !args.nil? && (args.is_a? Class)
      my_each { |i| return false unless i.is_a?(args) }
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
      to_a.my_each { |i| return true if yield(i) }
      return false
    elsif args.nil?
      to_a.my_each { |i| return true if i }
    elsif !args.nil? && (args.is_a? Class)
      to_a.my_each { |i| return true if i.is_a?(args) }
    elsif !args.nil? && args.class == Regexp
      to_a.my_each { |i| return true if args.match(i) }
    else
      to_a.my_each { |i| return true if i == args }
    end
    false
  end

  # my_none method
  def my_none?(arg = nil)
    if block_given?
      my_each { |i| return false if yield i }
    elsif arg.nil?
      my_each { |i| return false if i }
    elsif arg.is_a?(Class)
      my_each { |i| return false if i.class == arg }
    elsif arg.class == Regexp
      my_each { |i| return false if arg.match(i) }
    else
      my_each { |i| return false if i == arg }
    end
    true
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
    return to_enum unless block_given? || !proc.nil?

    arr = []
    if proc
      my_each { |i| arr << proc.call(i) }
    else
      my_each { |i| arr << yield(i) }
    end
    arr
  end

  # my_inject method
  def my_inject(*acc)
    arr = to_a
    return raise LocalJumpError, 'no block given' if !block_given? && acc[0].nil? && acc[1].nil?

    if acc.size == 1
      if acc[0].is_a?(Symbol)
        result = arr[0]
        (arr.length - 1).times do |i|
          result = arr[i + 1].send(acc[0], result)
        end
        result
      elsif acc[0].is_a?(Integer)
        k = acc[0]
        arr.my_each { |a| k = yield(k, a) }
        k
      end
    elsif acc.size == 2
      result = acc[0]
      arr.my_each { |a| result = a.send(acc[1], result) }
      result
    else
      accum = arr[0]
      (arr.length - 1).times do |i|
        accum = yield(accum, arr[i + 1])
      end
      accum
    end
  end
end

# multiply_els method
def multiply_els(arr)
  arr.my_inject { |acc, b| acc * b }
end
