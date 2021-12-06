input = File.read(ARGV[0]).chomp.split(",").map(&:to_i)

def init_new_fish_counts
  {
    0 => 0,
    1 => 0,
    2 => 0,
    3 => 0,
    4 => 0,
    5 => 0,
    6 => 0,
    7 => 0,
    8 => 0
  }
end

counts = init_new_fish_counts

input.each do |timer|
  counts[timer] += 1
end

256.times do |i|
  new_counts = init_new_fish_counts

  # old fish make babies
  new_counts[8] = counts[0]
  new_counts[6] = counts[0]

  counts.each do |counter, count|
    unless counter == 0
      new_counts[counter-1] += count
    end
  end

  counts = new_counts
end

total = counts.values.inject(:+)

puts total
