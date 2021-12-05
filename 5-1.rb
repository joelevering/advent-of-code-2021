def get_direction_method(one, two)
  if one < two
    :+
  else # we won't call this if there's a chance they're equal
    :-
  end
end


all_coords = {}

File.foreach(ARGV[0]) do |line|
  # find first and last points
  first_and_last = line.chomp.split(" -> ")
  first = first_and_last.first.split(",").map(&:to_i)
  last = first_and_last.last.split(",").map(&:to_i)

  # find all points in line
  coords = [first]
  if first.first == last.first # it's a vertical line
    x = first.first
    y_max = [first.last, last.last].max
    y_min = [first.last, last.last].min
    vert_delta = y_max - y_min - 1
    if vert_delta > 0
      vert_delta.times do |i|
        coords << [x, (y_min + i+1)]
      end
    end
  elsif first.last == last.last # it's a horizontal line
    y = first.last
    x_max = [first.first, last.first].max
    x_min = [first.first, last.first].min

    horiz_delta = x_max - x_min - 1
    if horiz_delta > 0
      horiz_delta.times do |i|
        coords << [(x_min + i+1), y]
      end
    end
  else
    x_dir = get_direction_method(first.first, last.first)
    y_dir = get_direction_method(first.last, last.last)

    sorted = [first.first, last.first].minmax
    delta = sorted.last - sorted.first - 1

    if delta > 0
      delta.times do |i|
        coords << [first.first.send(x_dir, i+1), first.last.send(y_dir, i+1)]
      end
    end
  end
  coords << last

  # add coordinates to storage
  coords.each do |coord_arr|
    if !all_coords[coord_arr.first]
      all_coords[coord_arr.first] = {coord_arr.last => 1}
    elsif !all_coords[coord_arr.first][coord_arr.last]
      all_coords[coord_arr.first][coord_arr.last] = 1
    else
      all_coords[coord_arr.first][coord_arr.last] += 1
    end
  end
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
