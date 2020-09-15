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

end