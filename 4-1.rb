input = File.read(ARGV[0]).chomp.split("\n")

numbers_to_draw = {}
input.shift.split(",").each_with_index { |num, i| numbers_to_draw[num] = i }

current_board = nil
boards = []

# generates an array of arrays (boards) that are arrays of rows of hashes
# that include number and order that number will be drawn according to the input
input.each do |row|
  if row.empty?
    if current_board
      boards << current_board
    end

    current_board = []
  else
    current_board << row.split(" ").map do |num|
      {number: num.to_i, order: numbers_to_draw[num]}
    end
  end
end

def any_rows_solved?(board, i)
  board.any? do |row|
    row.all? do |num_hash|
      num_hash[:order] <= i
    end
  end
end

def any_columns_solved?(board, i)
  (0..4).any? do |x|
    board.all? do |row|
      row[x][:order] <= i
    end
  end
end

def is_solved?(board, i)
  any_rows_solved?(board, i) || any_columns_solved?(board, i)
end

def get_board_total(board, i)
  sum = 0
  last = nil

  board.each do |row|
    row.each do |num_hash|
      if num_hash[:order] > i
        sum += num_hash[:number]
      elsif num_hash[:order] == i
        last = num_hash[:number]
      end
    end
  end

  puts "Sum: #{sum}, Last: #{last}"
  sum * last
end


# time to solve

solution = nil

(4..numbers_to_draw.length-1).each do |i| # can't have winning boards before 5 drawn numbers
  break if solution
  boards.each do |board|
    if is_solved?(board, i)
      solution = get_board_total(board, i)
      break
    end
  end
end

puts solution
