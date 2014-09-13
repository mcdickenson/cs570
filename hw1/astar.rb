class Astar

  # todo: define classes for states and search nodes
  def initialize(start, goal, heuristic)
    raise "Start node does not have neighbors" unless start.respond_to?(:neighbors)
    @start = start
    @goal  = goal
    self.class.send(:define_method, :heuristic_cost, heuristic)
    # raise "Start node does not have a distance_to function" unless start.respond_to?(:distance_to)
    # search(start, goal) # output is handled by the caller
  end

  def search(start=@start, goal=@goal)
    visited = []
    to_visit = [start]

    path_so_far = {}
    cost = {start => 0}
    estimated_cost = { start => cost[start]+ heuristic_cost(start, goal) }

    until to_visit.empty? do
      current = to_visit.sort_by { |node| estimated_cost[node] }.first
      return path_from(path_so_far, goal) if current == goal

      to_visit.delete(current)
      visited << current
      current.neighbors.each do |neighbor|
        puts neighbor
        next if visited.include? neighbor

        tentative_cost = cost[current] + 1 # 1=current.distance_to(neighbor)

        if (!to_visit.include?(neighbor)) || (tentative_cost < cost[neighbor])
          path_so_far[neighbor] = current
          cost[neighbor] = tentative_cost
          estimated_cost[neighbor] = tentative_cost + heuristic_cost(neighbor, goal)
          to_visit << neighbor unless to_visit.include?(neighbor) # could maybe use an elsif to avoid this
        end 
      end # neighbors
    end # until

    return :failure
  end # search

  def path_from(path_so_far, current)
    if path_so_far.keys.include? current
      path = path_from(path_so_far, path_so_far[current])
      path << current
      return path
    else
      return [current] # todo: may need to do some flattening/joining
    end
  end # path_from
end # Astar