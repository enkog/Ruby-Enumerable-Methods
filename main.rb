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

end