OPENERS = ["[", "(", "<", "{"]
CLOSERS_BY_OPENER = {
  "[" => "]",
  "(" => ")",
  "<" => ">",
  "{" => "}"
}

corrupted_counts =
  {
    "]" => 0,
    ")" => 0,
    ">" => 0,
    "}" => 0
  }
File.foreach(ARGV[0]) do |line|
  anticipated_closers = []

  line.chomp.each_char do |c|
    if OPENERS.include?(c)
      anticipated_closers << CLOSERS_BY_OPENER[c]
    elsif c != anticipated_closers.pop
      corrupted_counts[c] += 1
    end
  end
end

total =
  (corrupted_counts[")"] * 3) +
  (corrupted_counts["]"] * 57) +
  (corrupted_counts["}"] * 1197) +
  (corrupted_counts[">"] * 25137)

puts total
