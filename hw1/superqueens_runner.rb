require './astar.rb'
require './superqueens.rb'

s = SuperQueens.new(4)
# t = SuperQueens::SearchNode.new([nil]*4)
# t.neighbors
f = s.start
g = s.goal
t = SuperQueens::State.new(0, 0)
t == g