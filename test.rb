def h
  puts yield.nil?
end

h{ puts "haha"}