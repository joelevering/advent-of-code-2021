OPENERS = ["[", "(", "<", "{"]
CLOSERS_BY_OPENER = {
  "(" => ")",
  "[" => "]",
  "{" => "}",
  "<" => ">"
}
CLOSERS_BY_VALUE = {
  ")" => 1,
  "]" => 2,
  "}" => 3,
  ">" => 4
}

total_totals = []

File.foreach(ARGV[0]) do |line|
  anticipated_closers = []
  corrupted = false

  line.chomp.each_char do |c|
    if OPENERS.include?(c)
      anticipated_closers.unshift(CLOSERS_BY_OPENER[c])
    elsif c != anticipated_closers.shift
      corrupted = true
      break
    end
  end

  if !corrupted # score line
    total = 0
    anticipated_closers.each do |closer|
      total = (total * 5) + CLOSERS_BY_VALUE[closer]
    end

    total_totals << total
  end
end

puts total_totals.sort[total_totals.length/2]
