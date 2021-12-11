$octos = []
$flashes = 0

class Octo

  attr_reader :row, :column, :flashed, :energy

  def initialize(energy, row, column)
    @energy = energy
    @flashed = false
    @row = row
    @column = column
  end

  def increment_and_flash
    @energy += 1

    if @energy > 9 && !@flashed
      @flashed = true
      $flashes += 1
      flash(self, column, row)
    end
  end

  def reset
    if @flashed
      @flashed = false
      @energy = 0
    end
  end
end

File.open(ARGV[0], "r").each_with_index do |line, row|
  $octos << line.chomp.split("").map.with_index do |num, column|
    Octo.new(num.to_i, row, column)
  end
end

def print_octos
  $octos.each do |row|
    row.each do |octo|
      print octo.energy
    end
    print "\n"
  end

  print "\n"
end

def flash(octo,  x, y)
  if y-1 < 0
    in_first_row = true
  end

  if y+1 > 9
    in_last_row = true
  end

  if x-1 < 0
    in_first_column = true
  end

  if x+1 > 9
    in_last_column = true
  end

  if !in_first_row
    $octos[y-1][x].increment_and_flash

    if !in_first_column
      $octos[y-1][x-1].increment_and_flash
    end

    if !in_last_column
      $octos[y-1][x+1].increment_and_flash
    end
  end

  if !in_last_row
    $octos[y+1][x].increment_and_flash

    if !in_first_column
      $octos[y+1][x-1].increment_and_flash
    end

    if !in_last_column
      $octos[y+1][x+1].increment_and_flash
    end
  end

  if !in_first_column
    $octos[y][x-1].increment_and_flash
  end

  if !in_last_column
    $octos[y][x+1].increment_and_flash
  end
end

def increment_and_flash_octos
  $octos.each_with_index do |row, y|
    row.each_with_index do |octo, x|
      octo.increment_and_flash
    end
  end
end

def all_octos_flashed?
  $octos.all? do |row|
    row.all? do |octo|
      octo.flashed
    end
  end
end

def reset_octos
  $octos.each do |row|
    row.each do |octo|
      octo.reset
    end
  end
end

def take_turns(num)
  print_octos

  synchronization_turn = nil

  num.times do |i|
    increment_and_flash_octos
    if all_octos_flashed?
      synchronization_turn = i+1
      break
    end
    reset_octos
    print_octos
  end

  synchronization_turn
end

puts take_turns(300)

puts $flashes
