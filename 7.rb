input = File.read(ARGV[0]).chomp.split(",").map(&:to_i)

max = input.max
previous_low = 999999999
result = nil

def crab_fuel(difference)
  total = 0
  (difference+1).times do |x|
    total += x
  end
  total
end

max.times do |i|
  total = 0

  input.each do |n|
    total += crab_fuel((n-i).abs)
  end

#  puts "#{i}: #{total} fuel"
  if total < previous_low
    previous_low = total
    result = i
  end

  if total > previous_low
    position_result = i-1
    break
  end
end

puts result
puts previous_low
