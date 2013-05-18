require "colorize"
require "./Board"
require "./Tile"
require "./LookUp"
require "./RegexSolver"

# Class to run the Command line interface
class CommandLine

  attr_accessor :board, :lookUp, :help, :rack, :commands

  # Initialize the board, rack, help prompt
  def initialize( boardFile, dictionaryFile, scrabbleSolver )
    # board with the working tiles
    @board = Board.new( boardFile )
    # array of all availble words
    @lookUp = LookUp.new( dictionaryFile )
    # player's available tiles
    @rack = []

    # writes our command line help and explanation of availble commands
    @cliHelp = "Scrabble Solver Command Line Interface\n Written By Jesse Jurman\n\n"
    @cliHelp += "Write a line: ".green
    @cliHelp += ">> w x y [down | right] line \n".blue
    @cliHelp += "Update rack: ".green
    @cliHelp += ">> r letters\n".blue
    @cliHelp += "Get words on Board: ".green
    @cliHelp += ">> g\n".blue
    @cliHelp += "Solve for next word: ".green
    @cliHelp += ">> s\n".blue
    @cliHelp += "Validate check on board: ".green
    @cliHelp += ">> v\n".blue
    @cliHelp += "Print the board: ".green
    @cliHelp += ">> p (true, true)\n".blue
    @cliHelp += "Clear output: ".green
    @cliHelp += ">> c\n".blue
    @cliHelp += "Test input: ".green
    @cliHelp += ">> t\n".blue
    @cliHelp += "Show these commands: ".green
    @cliHelp += ">> h\n".blue
    @cliHelp += "Quit the Command Line: ".green
    @cliHelp += ">> q\n".blue

    # command hash, which takes input and runs methods
    @commands = {
      "w" => lambda { |pipe| board_write(pipe) },
      "r" => lambda { |pipe| update_rack(pipe) },
      "g" => lambda { |pipe| get_words },
      "s" => lambda { |pipe| next_solve },
      "v" => lambda { |pipe| validate },
      "p" => lambda { |pipe| print_board(pipe) },
      "c" => lambda { |pipe| clear_screen },
      "t" => lambda { |pipe| test_input },
      "h" => lambda { |pipe| print_help },
      "q" => lambda { |pipe| cli_quit }
    }

  end

  # Print the help screen... in COLOR!
  def print_help
    puts @cliHelp
  end

  # Print the current Board
  # pipe is in the following form:
  #   p (true, false)
  def print_board( pipe = "p true false" )
    spipe = pipe.split(" ")
    spipe.delete("p")
    spipe == [] ?  spipe = ["true", "false"] : spipe = spipe
    puts @board.show_board( spipe[0], spipe[1])
    puts "RACK: #{@rack.join(",")}".yellow
  end

  # write a single line on the board
  # pipe is in the folowing form:
  #   w <x> <y> (down|right) <line> 
  def board_write( pipe )
    spipe = pipe.split(" ")
    spipe[3] == "down" ? dir = :down : dir = :right
    @board.write_line( spipe[1].to_i, spipe[2].to_i, dir, spipe[4] )
  end

  # update the rack with new letters from the input
  def update_rack( newLetters )
    @rack << newLetters.split(" ").pop(newLetters.size/2)
  end

  # get all the words from the board
  def get_words
    puts @board.all_words.join(", ")
  end

  # compare all words on board with dictionary
  def validate
    if @lookUp.valid_check(@board.all_words)
      puts "All words check out"
    else
      puts "Ertt... a word is invalid\nChecking list now..."
      print @board.all_words

      @board.all_words.each do |word|
        puts "check on #{word}:"
        puts "result > #{@lookUp.valid_check([word])}"
      end

    end
  end

  # clear the output on the screen
  def clear_screen
    print `clear`
  end


  # solve using a solving algorithm
  def next_solve
    rs = RegexSolver.new(@board, @rack, @lookUp)
  end

  # test input for debugging
  def test_input
    board_write("w 7 7 right NOWHERE")
    board_write("w 6 8 down YOUNG")
    board_write("w 10 4 right TONIGHT")
    board_write("w 7 4 down FAST")
    board_write("w 7 5 down AS")
  end

  # quit the application
  def cli_quit
    puts "Thank you, have a nice day".green
  end


  # the main loop which the user runs inside
  def main_loop

    print_help
    print_board

    print ">> "
    while ( (input = gets.chomp) != "q" )
      @commands[input[0]].call(input) if @commands.has_key?(input[0]) 
      print ">> "
    end

  end
end
