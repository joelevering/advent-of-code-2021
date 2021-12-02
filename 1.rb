require 'csv'

count = 0
previous_depth = nil
previous_depths = []
increases = 0
trio_increases = 0

def single_depth_increase?(previous_depth, depth)
  previous_depth && depth > previous_depth
end

def trio_depth_increase?(previous_depths, depth, count)
  non_overlapping_previous_depth = previous_depths[count % 3]

  single_depth_increase?(non_overlapping_previous_depth, depth)
end

CSV.foreach(ARGV[0], "r") do |row|
  depth = row.first.to_i
  count += 1

  if single_depth_increase?(previous_depth, depth)
    increases += 1
  end

  if trio_depth_increase?(previous_depths, depth, count)
    trio_increases += 1
  end

  previous_depth = depth
  previous_depths[count % 3] = depth
end

puts "Increases: #{increases}"

puts "Trio comparison increases: #{trio_increases}"
