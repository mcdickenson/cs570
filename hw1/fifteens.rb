class Fifteens
  attr_reader :start, :goal

  ROWS = 4
  COLS = 4

  def initialize(board)
    raise "incorrect dimensions for board" unless board.size==ROWS and board.first.size==COLS
    @board = board
    @goal = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 0]]

    # todo: create a state

    # create a start node
    @start = SearchNode.new(board)
    # goal = SearchNode.new("blah")
    # create a heuristic function
  end

  def to_s
    "#{@board}"
  end

  def heuristic(node, goal=@goal)
    # manhattan distance for now
    dist = 0
    # todo: add data on knights' moves later 
    # this is important so that h is admissable
    goal.each_with_index do |row, row_ix|
      row.each_with_index do |cell, col_ix|
        current_row, current_col = Fifteens.find_position(cell, node.state)
        # find the corresponding cell in node
        # what's the horizontal distance?
        dist += (row_ix - current_row).abs + (col_ix-current_col).abs # min of this or knight moves
        # what's the vertical distance? 
      end
    end
    dist
  end

  def self.find_position(item, board)
    row = board.find_index { |row| row.include? item }
    col = board[row].find_index(item)
    [row, col]
  end

  class SearchNode

    attr_reader :state
    
    def initialize(state)
      @state = state      
      # puts row
      # puts col
    end

    def to_s
      "#{@state}"
    end

    def neighbors
      return @neighbors if @neighbors
      # horizontal moves
      # empty_row = @state.find_index { |row| row.include? 0 }
      # empty_col = @state[empty_row].find_index(0)
      empty_row, empty_col = Fifteens.find_position(0, @state) 
      h = horizontal_moves(empty_row, empty_col)
      # vertical moves
      v = vertical_moves(empty_row, empty_col)
      # knights moves
      moves = h.concat(v)
      # puts "moves: #{moves}"
      @neighbors = h.compact.map { |st| SearchNode.new(st) }
    end

    def horizontal_moves(empty_row, empty_col)
      move_left = switch(empty_row, empty_col, empty_row, empty_col+1)
      # puts "move left: #{move_left}"
      move_right = switch(empty_row, empty_col, empty_row, empty_col-1)
      # puts "move right: #{move_right}"
      [move_left, move_right]
    end

    def vertical_moves(empty_row, empty_col)
      move_up = switch(empty_row, empty_col, empty_row+1, empty_col)
      # puts "move up: #{move_up}"
      move_down = switch(empty_row, empty_col, empty_row-1, empty_col)
      # puts "move down: #{move_down}"
      [move_up, move_down]
    end 

    def knights_moves
    end

    def switch(row1, col1, row2, col2)
      # puts "[#{row1}, #{col1}, #{row2}, #{col2}]"
      return nil if out_of_bounds(row1, col1) or out_of_bounds(row2, col2)
      st = deep_copy(@state)
      st[row1][col1], st[row2][col2] = st[row2][col2], st[row1][col1]
      # puts "st: #{st}"
      return st
    end

    def out_of_bounds(row, col)
      (row < 0 or row > Fifteens::ROWS-1) or (col < 0 or col > Fifteens::COLS-1)
    end

    def deep_copy(obj)
      Marshal.load(Marshal.dump(obj))
    end
  end



end
