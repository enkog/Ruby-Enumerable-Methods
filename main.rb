module Enumerable
# my_each method
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
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
    return to_enum unless block_given?

    if args.nil?
      my_each { |i| return false unless yield i }
      true
    end
  end

# my_any method
  def my_any?(args = nil)
    return to_enum unless block_given?

    if args.nil?
      my_each { |i| return true if yield i }
      false
    end
  end

# my_none method
  def my_none?(args = nil)
    return to_enum unless block_given?

    if args.nil?
      my_each { |i| return false if yield i }
      true
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
    puts 'in the map'
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
    my_each { |a| acc = yield(acc, a) }
    acc
  end
end

# multiply_els method
def multiply_els(arr)
    arr.my_inject(1) { |acc, b| acc * b }
end