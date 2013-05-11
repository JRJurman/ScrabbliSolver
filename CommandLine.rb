require "colorize"
require "./Board"
require "./Tile"
require "./LookUp"

# Class to run the Command line interface
class CommandLine

  attr_accessor :board, :lookUp, :help, :rack, :commands

  # Initialize the board, rack, help prompt
  def initialize( boardFile, dictionaryFile, scrabbleSolver )
    @board = Board.new( boardFile )
    @lookUp = LookUp.new( dictionaryFile )
    @rack = []

    @cliHelp = "Scrabble Solver Command Line Interface\n Written By Jesse Jurman\n\n"
    @cliHelp += "Write a line: \n> w x y [down | right] line \n"
    @cliHelp += "Update rack: \n> r letters\n"
    @cliHelp += "Get words on Board: \n> g\n"
    @cliHelp += "Solve for next word: \n> s\n"
    @cliHelp += "Validate check on board: \n> v\n"
    @cliHelp += "Print the board: \n> p (true, true)\n"
    @cliHelp += "Show these commands: \n> h\n"
    @cliHelp += "Quit the Command Line: \n> q\n"

    @commands = {
      "w" => lambda { |pipe| board_write(pipe) },
      "r" => lambda { |pipe| update_rack(pipe) },
      "g" => lambda { |pipe| get_words },
      "s" => lambda { |pipe| solve },
      "v" => lambda { |pipe| validate },
      "p" => lambda { |pipe| print_board(pipe) },
      "h" => lambda { |pipe| print_help },
      "q" => lambda { |pipe| cli_quit }
    }

  end

  # Print the help screen.. in GREEN!
  def print_help
    puts @cliHelp.green
  end

  # Print the current Board
  # pipe is in the following form:
  #   p (true, false)
  def print_board( pipe = "p true false" )
    spipe = pipe.split(" ")
    spipe.delete("p")
    spipe == [] ?  spipe = ["true", "false"] : spipe = spipe
    puts @board.show_board( spipe[0], spipe[1])
    puts "RACK: #{@rack.join(",")}"
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
    rack << newLetters.split(" ").pop(newLetters.size)
  end

  # get all the words from the board
  def get_words
    puts @board.all_words
  end

  # compare all words on board with dictionary
  def validate
    if @lookUp.valid_check(@board.all_words)
      puts "All words check out"
    else
      puts "Ertt... a word is invalid\nChecking list now..."
      print @board.all_words
      gets

      @board.all_words.each do |word|
        puts "check on #{word}:"
        puts "result > #{@lookUp.valid_check([word])}"
      end

    end
  end

  # solve using a solving algorithm
  def next_solve
  end

  # quit the application
  def cli_quit
    puts "Thank you, have a nice day".green
  end


  # the main loop which the user runs inside
  def main_loop

    print_help
    print_board

    print "> "
    while ( (input = gets.chomp) != "q" )
      @commands[input[0]].call(input)
      print "> "
    end

  end
end
