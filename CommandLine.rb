require "colorize"
require "./Board"
require "./Tile"

# Class to run the Command line interface
class CommandLine

  attr_accessor :board, :help, :rack, :commands

  # Initialize the board, rack, help prompt
  def initialize( boardFile, dictionaryFile, scrabbleSolver )
    @board = Board.new( boardFile )
    @rack = []

    @cliHelp = "Scrabble Solver Command Line Interface\n Written By Jesse Jurman\n\n"
    @cliHelp += "Write a line: \n> w x y [down | right] line \n"
    @cliHelp += "Update rack: \n> r letters\n"
    @cliHelp += "Solve for next word: \n> s\n"
    @cliHelp += "Show these commands: \n> h\n"
    @cliHelp += "Quit the Command Line: \n> q\n"

    @commands = {
      "w" => lambda { |pipe| board_write(pipe) },
      "r" => lambda { |pipe| update_rack(pipe) },
      "s" => lambda { |pipe| solve },
      "h" => lambda { |pipe| print_help },
      "q" => lambda { |pipe| cli_quit }
    }

  end

  # Print the help screen.. in GREEN!
  def print_help
    puts @cliHelp.green
  end

  # Print the current Board
  def print_board
    puts @board.show_board
  end

  # write a single line on the board
  def board_write( pipe )
    spipe = pipe.split(" ")
    spipe[3] == "down" ? dir = :down : dir = :right
    @board.write_line( spipe[1].to_i, spipe[2].to_i, dir, spipe[4] )
  end

  # update the rack with new letters from the input
  def update_rack( newLetters )
    rack << newLetters.split(" ")
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
      print_board
      print "> "
    end

  end
end
