result = 0

File.foreach(ARGV[0]) do |line|
  formatted = line.chomp.split(" | ").map(&:split)
  digits = formatted.first
  output = formatted.last

  solution_key = {}
  (0..9).each do |n|
    solution_key[n] = nil
  end

  zero_or_six_or_nine = []
  two_or_three_or_five = []

  digits.each do |digit_string|
    chars = digit_string.split("")

    case digit_string.length
    when 2
      solution_key[1] = chars.sort
    when 4
      solution_key[4] = chars.sort
    when 3
      solution_key[7] = chars.sort
    when 5
      two_or_three_or_five << chars.sort
    when 6
      zero_or_six_or_nine << chars.sort
    when 7
      solution_key[8] = chars.sort
    end
  end

  two_or_five = two_or_three_or_five.select do |chars|
    if (solution_key[1] - chars).empty?
      solution_key[3] = chars

      false
    else
      true
    end
  end

  six_or_nine = zero_or_six_or_nine.select do |chars|
    remnant = solution_key[3] - chars
    if remnant.any? && !solution_key[1].include?(remnant.first)
      solution_key[0] = chars

      false
    else
      true
    end
  end

  six_or_nine.each do |chars|
    if (solution_key[1] - chars).empty?
      solution_key[9] = chars
    else
      solution_key[6] = chars
    end
  end

  two_or_five.each do |chars|
    if (solution_key[6] - chars).length == 1
      solution_key[5] = chars
    else
      solution_key[2] = chars
    end
  end

  # solve output
  digit_arr = output.map do |digit_string|
    output_chars = digit_string.split("")
    correct_digit = nil
    solution_key.each do |digit, chars|
      if output_chars.length == chars.length && (output_chars - chars).empty?
        correct_digit = digit
      end
    end
    correct_digit
  end

  result += digit_arr.join.to_i
end

puts result
