require 'csv'

counts = []

CSV.open(ARGV[0], 'r') { |csv| csv.first.first.length.times { counts << 0 } }

CSV.foreach(ARGV[0], "r") do |row|
  chars = row.first.split("")

  chars.each_with_index do |c, i|
    if c == "1"
      counts[i] += 1
    else
      counts[i] -= 1
    end
  end
end

gamma_digits = []
epsilon_digits = []

counts.each do |count|
  if count > 0
    gamma_digits << 1
    epsilon_digits << 0
  elsif count < 0
    gamma_digits << 0
    epsilon_digits << 1
  else
    raise "Tie!!"
  end
end

gamma = gamma_digits.join.to_i(2)
epsilon = epsilon_digits.join.to_i(2)
power_consumption = gamma * epsilon

puts power_consumption
