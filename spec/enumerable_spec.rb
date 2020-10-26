require './lib/enumerable.rb'

RSpec.describe 'Enumerable' do
  let(:num_arr) { [1, 2, 4, 6, 8, 21] }
  let(:test_range) { (1..5) }
  let(:test_hash) { { a: 100, c: 300, b: 200 } }
  let(:test_arr) { %w[hello hi dog] }
  let(:test_proc) { proc { |num| num * 2 } }
  let(:test_search) { proc { |memo, word| memo.length > word.length ? memo : word } }

  # my_each method
  context '#my_each' do
    it 'returns an enumerator if no block is given' do
      expect(test_arr.my_each).to be_a(Enumerator)
    end

    it 'returns every value of the array in the existing order' do
      expect(test_arr.my_each { |x| print x, ' -- ' }).to eq(test_arr.each { |x| print x, ' -- '})
    end

    it 'returns every value of the number array in the existing order' do
      expect(num_arr.my_each { |x| x}).to eq(num_arr.each { |x| x})
    end

    it 'returns every value of the range in the existing order' do
      expect(test_range.my_each { |el| el }).to eq(test_range.each { |el| el })
    end

    it 'returns every value of the hash in the existing order' do
      expect(test_hash.my_each { |k, _v| k }).to eq(test_hash.each { |k, _v| k})
    end
  end

  # my_each_with_index method
  context '#my_each_with_index' do
    it 'returns an enumerator if no block is given' do
      expect(test_arr.my_each).to be_a(Enumerator)
    end

    it 'returns each element in the array with its index' do
      expect(test_arr.my_each_with_index { |el, i| puts "#{el} : #{i}"}).to eq(test_arr.each_with_index { |el, i| puts "#{el} : #{i}"})
    end

    it 'returns each element in the array with its index' do
      expect(num_arr.my_each_with_index { |x, i| puts "#{i} -> #{x}"}).to eq(num_arr.each_with_index { |x, i| puts "#{i} -> #{x}"})
    end

    it 'returns each element in a range with its index' do
      expect(test_range.my_each_with_index { |x, i| puts "#{i} -> #{x}"}).to eq(test_range.each_with_index { |x, i| puts "#{i} -> #{x}"})
    end

    it 'returns each key-value pair and their index in a hash' do
      expect(test_hash.my_each_with_index { |k, v| puts "#{k} -> #{v}"}).to eq(test_hash.each_with_index { |k, v| puts "#{k} -> #{v}"})
    end
  end

  # select method
  context '#select' do
    it 'returns an enumerator if no block is given' do
      expect(test_arr.my_each).to be_a(Enumerator)
    end

    it 'returns all elements of the array for which the block returns a true' do
      expect(num_arr.my_select { |num|  num.even?  }).to eq(num_arr.select { |num|  num.even?  })
    end

    it 'returns all elements of the array for which the block returns a true' do
      expect(test_range.my_select(&:even?)).to eql([2, 4])
    end
  end
end
