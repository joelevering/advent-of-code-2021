require 'csv'

all = CSV.read(ARGV[0])

def generate_counts(rows, index)
  counts = {"0" => 0, "1" => 0}

  rows.each_with_index do |row, i|
    digits = row.first.split("")

    counts[digits[index]] += 1
  end

  counts
end

def most_common_digit(counts)
  if counts["0"] > counts["1"]
    return "0"
  else
    return "1"
  end
end

def least_common_digit(counts)
  if counts["1"] < counts["0"] && counts["1"] != 0
    return "1"
  else
    return "0"
  end
end

def find_new_oxygen_numbers(possible_rows, i)
  counts = generate_counts(possible_rows, i)
  oxygen_digit = most_common_digit(counts)

  possible_rows.select {|row| row.first.split("")[i] == oxygen_digit}
end

def find_new_co2_numbers(possible_rows, i)
  counts = generate_counts(possible_rows, i)
  co2_digit = least_common_digit(counts)

  possible_rows.select {|row| row.first.split("")[i] == co2_digit}
end

possible_oxygen_numbers = all
possible_co2_numbers = all

digit_length = all.first.first.length

(0..digit_length-1).each do |i|
  if possible_oxygen_numbers.length != 1
    possible_oxygen_numbers = find_new_oxygen_numbers(possible_oxygen_numbers, i)
  end
  if possible_co2_numbers.length != 1
    possible_co2_numbers = find_new_co2_numbers(possible_co2_numbers, i)
  end
end

oxygen = possible_oxygen_numbers.first.first.to_i(2)
co2 = possible_co2_numbers.first.first.to_i(2)

puts "Oxygen: #{oxygen}, CO2: #{co2}, total: #{oxygen*co2}"
