require './astar.rb'
require './superqueens.rb'

# s = SuperQueens.new(4)
# # t = SuperQueens::SearchNode.new([nil]*4)
# # t.neighbors
# f = s.start
# g = s.goal
# t = SuperQueens::State.new(0, 0)
# t == g

size = ARGV[0].to_i
result = :failure
max_attacks = 0

while result == :failure && max_attacks < size
  sq = SuperQueens.new(size, max_attacks)
  f = sq.start
  a = Astar.new(f, sq.goal, f.node.method(:heuristic).to_proc)
  result = a.search
  puts max_attacks
  max_attacks += 1
end

if result == :failure
  puts "No acceptable placement was found"
else
  puts "An optimal placement for a board of size #{size}:"
  puts result.last.node
  puts
  puts "There are #{result.last.attacks} attacking pairs"
end
