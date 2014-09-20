HW1
=====

# Environment

This submission has been developed and tested on OS X 10.9 using Ruby 2.0.0-p353.

# A* Implementation

`astar.rb` contains a Ruby implementation of the A* algorithm. The initializer takes a starting state, a goal state, and a heuristic function. (No hard distinction is made in the code between search nodes and states. Although I recognize this difference and we have discussed it in class, this keeps the code slightly simpler.) 

Once an instance of the Astar has been created, the `search` function can be called. When a solution is found, the path for that solution (including the starting node) is returned. If no solution is found, the symbol `:failure` is returned.

# Problem 1: Fifteens Puzzle with Knight Moves

## Description

`fifteens.rb` contains a Ruby implementation for creating instances of the Fifteens Puzzle with knight moves.

`fifteens_knight_runner.rb` contains a Ruby script that takes input from STDIN, creates an instance of the Fifteens Puzzle, searches for a solution with A*, and prints the output.

## Input 

Because the `fifteens_knight_runner` script accepts input from STDIN it can be run in several ways. The input specified in the homework is stored in `knight_input.txt `. Here are some examples for running the script with this input:

```
cat knight_input.txt | ruby fifteens_knight_runner.rb
ruby fifteens_knight_runner.rb < knight_input.txt
```

## Output

The output prints states of the puzzle (including the initial state), separated by newlines, as well as the length of the optimal solution (again, the initial state is included). 

Output can be redirected to a file via STDOUT. For example:

```
ruby fifteens_knight_runner.rb < knight_input.txt > knight_output.txt
```

The output for the example problem is as follows:

```
Optimal solution states:
  1  2 12 13
  5  6  7  8
  9  3  4  0
 11 14 15 10

  1  2 12 13
  5  0  7  8
  9  3  4  6
 11 14 15 10

  1  2 12  0
  5 13  7  8
  9  3  4  6
 11 14 15 10

  1  2 12  4
  5 13  7  8
  9  3  0  6
 11 14 15 10

  1  2 12  4
  5 13  7  8
  9  3 11  6
  0 14 15 10

  1  2 12  4
  5  0  7  8
  9  3 11  6
 13 14 15 10

  1  2 12  4
  5  6  7  8
  9  3 11  0
 13 14 15 10

  1  2  0  4
  5  6  7  8
  9  3 11 12
 13 14 15 10

  1  2  3  4
  5  6  7  8
  9  0 11 12
 13 14 15 10

  1  2  3  4
  5  6  7  8
  9 10 11 12
 13 14 15  0


Optimal solution length: 10
```

A second solution (equal in length) was also discovered while completing the homework with a slightly different heuristic function:

```
Optimal solution states:
  1  2 12 13
  5  6  7  8
  9  3  4  0
 11 14 15 10

  1  2  0 13
  5  6  7  8
  9  3  4 12
 11 14 15 10

  1  2  3 13
  5  6  7  8
  9  0  4 12
 11 14 15 10

  1  2  3 13
  5  0  7  8
  9  6  4 12
 11 14 15 10

  1  2  3  0
  5 13  7  8
  9  6  4 12
 11 14 15 10

  1  2  3  4
  5 13  7  8
  9  6  0 12
 11 14 15 10

  1  2  3  4
  5 13  7  8
  9  6 11 12
  0 14 15 10

  1  2  3  4
  5  0  7  8
  9  6 11 12
 13 14 15 10

  1  2  3  4
  5  6  7  8
  9  0 11 12
 13 14 15 10

  1  2  3  4
  5  6  7  8
  9 10 11 12
 13 14 15  0


Optimal solution length: 10
```

# Problem 2: SuperQueens

## Description

`superqueens.rb` contains a Ruby implementation for creating instances of the FiN-Queens puzzle with knight moves.

`superqueens_runner.rb` contains a Ruby script that takes an input parameter, creates an instance of the N-Queens puzzle, searches for a solution with A*, and prints the output.

## Input 

The size of the board is passed as an argument to the Ruby script:

```
ruby superqueens_runner.rb 7
```

## Output

The output prints the final layout of the board and the number of attacking pairs. 

Example output for a board of size 7 is:

```
An optimal placement for a board of size 7:
1 0 0 0 0 0 0
0 0 0 1 0 0 0
0 0 0 0 1 0 0
0 1 0 0 0 0 0
0 0 0 0 0 1 0
0 0 0 0 0 0 1
0 0 1 0 0 0 0

There are 4 attacking pairs
```
