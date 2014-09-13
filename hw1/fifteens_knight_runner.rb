require './astar.rb'
require './fifteens.rb'

ary = ARGF.each_with_object([]) { |line, ary| ary << line.split.map { |x| x.to_i } }
# puts ary
# puts ary.size
# puts ary.first.size

f = Fifteens.new(ary)
g = f.goal
puts "f: #{f}"

# s = Fifteens::SearchNode.new(ary)
puts f.heuristic(f.start)


# s.neighbors.each do |n|
#   puts "n: #{n.state}"
# end

a = Astar.new(f.start, f.goal, f.method(:heuristic).to_proc)
a.search