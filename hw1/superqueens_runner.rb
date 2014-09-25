require './astar.rb'
require './superqueens.rb'

size = ARGV[0].to_i
result = :failure
max_attacks = 0

while result == :failure && max_attacks < size
  sq = SuperQueens.new(size, max_attacks)
  f = sq.start
  a = Astar.new(f, sq.goal, f.node.method(:heuristic).to_proc)
  result = a.search
  max_attacks += 1
end

File.open('queens-mcd31.csv', 'w') do |file|
  if result == :failure
    file.puts "No acceptable placement was found"
  else
    file.puts "There are #{result.last.attacks} attacking pairs"
    file.puts "An optimal placement for a board of size #{size}:"
    file.puts result.last.node    
  end
end
