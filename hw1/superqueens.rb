class SuperQueens
  attr_reader :start, :goal

  def initialize(size, goal)
    @columns = (0..size-1).to_a.shuffle
    @start = State.new(size**2, SearchNode.new(@columns))
    @goal = State.new(goal)
  end

  class State
    attr_reader :attacks, :node

    def initialize(attacks, node=nil)
      @attacks = attacks
      @node = node
    end

    def ==(obj)
      obj.class == self.class && obj.attacks == attacks 
    end
    alias_method :eql?, :==

    def hash
      node.hash
    end

    def neighbors
      node.neighbors
    end

    def to_s
      "#{@node}"
    end
  end

  class SearchNode
    attr_reader :columns

    def initialize(columns)
      @columns = columns
      @size = @columns.size
    end

    def to_s
      str = ""
      (0..@size-1).each do |row|
        cols = @columns.each_index.select { |i| @columns[i]==row}
        r = ["_"]*@size
        cols.each { |i| r[i] = "Q" }
        str += r.join(",") + "\n"
      end
      str
    end

    def neighbors
      @neighbors ||= valid_moves.map do |x|
        sn = SearchNode.new(x)
        st = State.new(sn.heuristic, sn)
      end
    end

    def valid_moves
      current_h = heuristic
      @columns.permutation.select { |p| heuristic(p) <= current_h }
    end

    def collisions(x1, y1, x2, y2)
      diffx = (x1-x2).abs
      diffy = (y1-y2).abs
      diffx == diffy or
      [diffx, diffy] == [1, 2] or
      [diffx, diffy] == [2, 1]
    end

    def heuristic(state=@columns, goal=0)
      state = state.node.columns if state.respond_to? :node
      attacking_pairs = 0
      (0..@size-1).each do |col1|
        (col1+1..@size-1).each do |col2|
          attacking_pairs += 1 if collisions(state[col1], col1, state[col2], col2)
        end
      end
      attacking_pairs
    end

  end
end

