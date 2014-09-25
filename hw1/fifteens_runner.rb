#!/usr/bin/ruby
require './astar.rb'
require './fifteens.rb'

ary = ARGF.each_with_object([]) { |line, ary| ary << line.split(',').map { |x| x.to_i } }
f = Fifteens.new(ary)
a = Astar.new(f.start, f.goal, f.method(:heuristic).to_proc)
result = a.search

File.open('tilepuz-mcd31.txt', 'w') do |file|
  file.puts "Optimal solution length: #{result.size-1}" 
  file.puts "\nOptimal solution states:"
  file.puts result
end
