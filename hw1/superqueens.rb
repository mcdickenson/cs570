class SuperQueens
  attr_reader :start, :goal

  def initialize(size)
    # 1: start with empty board
    # @board = [[0]*size]*size
    # goal: column sums all == 1, no attacks

    # 2: start with vector of columns
    # @state = [nil] * size

    # 3: put them all in one row/col and move until there are no more attacks

    # 4: put one in the top-left spot
    #    neighbors: anywhere that won't cause a conflict (constr propagation)
    #    if none available, backtrack (a* should do that)

    @size = size
    @columns = [nil]*size
    @start = State.new(size**2, SearchNode.new(@columns))
    @goal = State.new(0, 0) # if size > 4

    # ***
    # 5: random start
    # (putting them all in same row should maximize # attacking pairs)
    # neighbors: all n(n-1) boards formed by moving any queen within its column
    # any one with <= heuristic cost is ok
    # constraint prop should take care of this
    # stop when you haven't found any lower in ___ iterations
    # goal: minimize number of attacking pairs
    # for n>4, this number should be zero
    # ***

    # todo: implement cost function
    # (increase in # attacking pairs)
    # todo: define state class
    # state is number of attacking pairs
  end

  def self.collision(x1, y1, x2, y2)
    # puts "x1: #{x1} y1: #{y1} x2: #{x2} y2: #{y2}"
    (x1 == x2) or 
    (y1 == y2) or 
    (x1-x2).abs == (y1-y2).abs or
    [(x1-x2).abs, (y1-y2).abs] == [1, 2] or
    [(x1-x2).abs, (y1-y2).abs] == [2, 1]
  end

  def heuristic(state)
    attacking_pairs = 0
    (0..@size-2).each do |col1|
      row1 = state[col1]
      (col1+1..@size-1).each do |col2|
        row2 = state[col2]
        attacking_pairs += 1 if self.collision(row1, col1, row2, col2)
      end
    end
    attacking_pairs
  end

  class State
    attr_reader :attacks, :empty_cols

    # number of attacking pairs
    def initialize(attacks, empty_cols, node=nil)
      @attacks = attacks
      @empty_cols = empty_cols
      @node = node
    end

    def ==(obj)
      obj.class == self.class && obj.attacks == attacks && obj.empty_cols == empty_cols
    end
    alias_method :eql?, :==

    def neighbors
      @node.neighbors
    end
  end

  class SearchNode
    def initialize(columns)
      @columns = columns
      @size = @columns.size
      @empty = @columns.find_index nil
    end

    def neighbors
      return [] unless @empty
      @neighbors ||= valid_moves.map do |x|
        st = deep_copy(@columns)
        st[@empty] = x
        sn = SearchNode.new(st)

        st = State.new(Fifteens::Heuristic(sn), @size-(@empty+1), sn)
      end
    end

    def valid_moves
      puts "checking valid moves"
      possible = []
      (0..@size-1).each do |row|
        next if on_occupied_space(row, @empty)
        possible << row
      end
      possible
    end

    def on_occupied_space(x, y)
      (0..@empty-1).each do |col|
        row = @columns[col]
        puts collision(row, col, x, y)
        return true if SuperQueens.collision(row, col, x, y)
      end
      return false
    end

    def deep_copy(obj)
      Marshal.load(Marshal.dump(obj))
    end

    # todo: boundary checking
    # def knight_move(x1, y1, x2, y2)
    #   ary = [(x1-x2).abs, (y1-y2.abs)]
    #   ary == [1, 2] or ary == [2,1]
    # end
  end
end

