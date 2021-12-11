result = 0

File.foreach(ARGV[0]) do |line|
  formatted = line.chomp.split(" | ").map(&:split)
  output = formatted.last

  output.each do |digit_string|
    if [2,3,4,7].include?(digit_string.length)
      result += 1
    end
  end
end

puts result
