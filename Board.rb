require "colorize"
require "./Tile.rb"

# Board Class, defines a scrabble board on which several tiles exist
class Board
  attr_accessor :board

  # Creates a new board, reads in from a txt file
  # and generates a 2 dimensional array
  def initialize( boardFile )
    @board = [[]]
    f = File.open( boardFile )
    f.each_char do |c|
      c != "\n" ? @board[@board.size()-1] << Tile.new(" ", c) : @board << []
    end
  end

  # Writes a character to the board
  # x, y = (1..15)
  # c = (A..Z, a..z)
  def write_char( x, y, c )
    @board[x][y] = Tile.new(c, "")
  end

  # Writes a line on the board
  # direction = (:left | :down)
  def write_board( x, y, direction, line )

  end

  # Prints the board to STDOUT
  def show_board
    @board.each do |tileSet|
      tileSet.each do |tile|
        print(" #{tile.show_tile}")
      end
      print(" \n")
    end
  end

end

#test run
b = Board.new( "board.txt" )
b.write_char( 7, 7, "f" )
b.write_char( 7, 8, "a" )
b.write_char( 7, 9, "c" )
b.write_char( 7, 10,"e" )
b.show_board