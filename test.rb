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
    def my_all?(args = nil)
        if block_given?
          my_each { |i| return false unless yield i }
          return true
        elsif args.nil?
          my_each { |i| return false if i == nil }
        elsif !args.nil? && args.is_a?(Class)
          my_each { |i| return false unless i.class != args }
        elsif !args.nil? && args.class == Regexp
          my_each { |i| return false unless args.match(i) }
        else
          my_each { |i| return false if i != args}
        end
        true
    end
end

p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_all?(/t/)                        #=> false
p [1,2i, 3.14].my_all?(Numeric)                       #=> true
p [nil, true, 99].my_all?                              #=> false
p [].my_all?                                           #=> true
