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

end