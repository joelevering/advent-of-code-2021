def get_and_format_first_and_last(line)
  first_and_last = line.chomp.split(" -> ").map {|ns| ns.split(",").map(&:to_i)}

  return first_and_last.first, first_and_last.last
end

def get_coords(first, last)
  x1 = first.first
  y1 = first.last
  x2 = last.first
  y2 = last.last

  coords = [first]
  if x1 == x2 # it's a vertical line
    y_max = [y1, y2].max
    y_min = [y1, y2].min
    vert_delta = y_max - y_min - 1

    if vert_delta > 0
      vert_delta.times do |i|
        coords << [x1, (y_min + i+1)]
      end
    end
  elsif y1 == y2 # it's a horizontal line
    x_max = [x1, x2].max
    x_min = [x1, x2].min

    horiz_delta = x_max - x_min - 1
    if horiz_delta > 0
      horiz_delta.times do |i|
        coords << [(x_min + i+1), y1]
      end
    end
  else
    x_dir = get_direction_method(x1, x2)
    y_dir = get_direction_method(y1, y2)

    sorted = [x1, x2].minmax
    delta = sorted.last - sorted.first - 1

    if delta > 0
      delta.times do |i|
        coords << [x1.send(x_dir, i+1), y1.send(y_dir, i+1)]
      end
    end
  end
  coords << last

  coords
end

def update_coords!(all, new)
  new.each do |coord_arr|
    x = coord_arr.first
    y = coord_arr.last

    if !all[x]
      all[x] = {y => 1}
    elsif !all[x][y]
      all[x][y] = 1
    else
      all[x][y] += 1
    end
  end
end

def get_direction_method(one, two)
  if one < two
    :+
  else # we won't call this if there's a chance they're equal
    :-
  end
end

all_coords = {}

File.foreach(ARGV[0]) do |line|
  first, last = get_and_format_first_and_last(line)

  coords = get_coords(first, last)

  update_coords!(all_coords, coords)
end


# find solution
solution = 0
all_coords.each do |x, y_hash|
  y_hash.each do |y, count|
    if count > 1
      solution += 1
    end
  end
end

# Test on sample data
# 9.times do |x|
#   9.times do |y|
#     if all_coords[x][y]
#       print all_coords[x][y]
#     else
#       print "."
#     end
#   end
#   print "\n"
# end

puts solution
