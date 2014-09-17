require './astar.rb'
require './fifteens.rb'

ary = ARGF.each_with_object([]) { |line, ary| ary << line.split.map { |x| x.to_i } }
f = Fifteens.new(ary)
a = Astar.new(f.start, f.goal, f.method(:heuristic).to_proc)
result = a.search

puts "\nOptimal solution states:"
puts result
puts "\nOptimal solution length: #{result.size}"