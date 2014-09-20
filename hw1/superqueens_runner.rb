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

while result == :failure
  sq = SuperQueens.new(size, max_attacks)
  f = sq.start
  a = Astar.new(f, sq.goal, f.node.method(:heuristic).to_proc)
  result = a.search
  puts max_attacks
  max_attacks += 1
end
# sq = SuperQueens.new(7)
# f = sq.start
# a = Astar.new(f, sq.goal, f.node.method(:heuristic).to_proc)
# result = a.search
puts result
puts result.last.attacks

# todo: in the runner, if you can get to a solution with n attacks, try for n-1