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

def take_steps(polymer, rules, steps)
  next_polymer = polymer

  steps.times do |i|
    puts i
    next_polymer = take_step(next_polymer, rules)
  end

  next_polymer
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

final = take_steps(polymer, rules, 10)

results = [
  final.count("N"),
  final.count("C"),
  final.count("B"),
  final.count("H")
]

result = results.max - results.min

puts result


