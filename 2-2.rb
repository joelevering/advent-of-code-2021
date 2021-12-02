require 'csv'

distance = 0
depth = 0
aim = 0

CSV.foreach(ARGV[0], "r") do |row|
  instruction_words = row.first.split
  directive = instruction_words.first
  value = instruction_words.last.to_i

  case directive
  when "forward"
    distance += value
    depth += (aim * value)
  when "down"
    aim += value
  when "up"
    aim -= value
  end
end

puts "Distance: #{distance} Depth: #{depth}"
puts "Total: #{distance*depth}"
