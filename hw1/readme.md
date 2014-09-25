HW1
=====

# Environment

This submission has been developed and tested on OS X 10.9 using Ruby 2.0.0-p353. It should also work with Ruby 1.8.7, 1.9.3, or 2.1.0.

# A* Implementation

`astar.rb` contains a Ruby implementation of the A* algorithm. The initializer takes a starting state, a goal state, and a heuristic function. (No hard distinction is made in the Fifteens problem between search nodes and states. Although I recognize this difference and we have discussed it in class, this keeps the code slightly simpler. The Queens puzzle does make such a distinction.) 

Once an instance of the Astar implementation has been created, the `search` function can be called. When a solution is found, the path for that solution (including the starting node) is returned. If no solution is found, the symbol `:failure` is returned.

# Problem 1: Fifteens Puzzle with Knight Moves

`fifteens.rb` contains a Ruby implementation for creating instances of the Fifteens Puzzle with knight moves. It relies on the file `knight_distance.txt` as part of the heuristic computation.

`fifteens_runner.rb` contains a Ruby script that takes input from STDIN, creates an instance of the Fifteens Puzzle, searches for a solution with A*, and prints the output.

`tilepuzmcd31` is the executable version of `fifteens_runner.rb`. If for some reason it is not executable on your system, run `chmod 755 tilepuzmcd31`. It can be run with `./tilepuzmcd31 "tilepuzinput.txt"`. 

The output prints states of the puzzle (including the initial state), separated by newlines, as well as the length of the optimal solution. Output is directed to `tilepuz-mcd31.txt`.


# Problem 2: SuperQueens


`superqueens.rb` contains a Ruby implementation for creating instances of the N-Queens puzzle with knight moves. `superqueens_runner.rb` contains a Ruby script that takes an input parameter, creates an instance of the N-Queens puzzle, searches for a solution with A*, and prints the output. The runner starts with a goal of 0 and increments it by 1 each time A* results in failure. `queensmcd31` is the executable version.

The size of the board is passed as an argument to the executable. E.g. for a 7x7 board the call is:

```
./queensmcd31 7
```

The output with the number of attacking pairs and the final layout of the board is stored in `queens-mcd31.csv`. 

