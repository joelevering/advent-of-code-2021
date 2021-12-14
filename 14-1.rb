polymer = nil
rules = {}

File.open(ARGV[0], "r").each_with_index do |line, i|
  if i == 0
    polymer = line.chomp
  elsif i > 1 # second line is blank
    formatted = line.chomp.split(" -> ")
    rules[formatted.first] = formatted.last
  end
end

def take_step(polymer, rules)
  new_polymer = ""
  next_char = nil

  polymer.each_char do |c|
    if !next_char
      new_polymer << c
      next_char = c
    else
      new_polymer << rules[next_char + c] + c
      next_char = c
    end
  end

  new_polymer
end

step_1_polymer = take_step(polymer, rules)
step_2_polymer = take_step(step_1_polymer, rules)
step_3_polymer = take_step(step_2_polymer, rules)
step_4_polymer = take_step(step_3_polymer, rules)
step_5_polymer = take_step(step_4_polymer, rules)
step_6_polymer = take_step(step_5_polymer, rules)
step_7_polymer = take_step(step_6_polymer, rules)
step_8_polymer = take_step(step_7_polymer, rules)
step_9_polymer = take_step(step_8_polymer, rules)
step_10_polymer = take_step(step_9_polymer, rules)

results = [
  step_10_polymer.count("N"),
  step_10_polymer.count("C"),
  step_10_polymer.count("B"),
  step_10_polymer.count("H")
]

result = results.max - results.min

puts result


