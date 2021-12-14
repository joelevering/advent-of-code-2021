heightmap = []

File.foreach(ARGV[0]) do |line|
  heightmap << line.chomp.split("").map do |c|
    {height: c.to_i, possible_low_point: true}
  end
end

heightmap.each do |row|
  heightmap.each do |point|

  end
end

puts heightmap.inspect
