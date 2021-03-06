require "colorize"
require "./Tile.rb"

# Board Class, defines a scrabble board on which several tiles exist
class Board
  attr_accessor :board

  # Creates a new board, reads in from an ASCII txt file
  # and generates a 2 dimensional array
  def initialize( boardFile )
    @board = [[]]
    f = File.open( boardFile )
    f.each_char do |c|
      # write empty tiles to the board, newlines indicate another row
      c != "\n" ? @board[@board.size()-1] << Tile.new(" ", c) : @board << []
    end
  end

  # Writes a character to the board
  # x, y = (1..15)
  # c = (A..Z, a..z)
  def write_char( x, y, c )
    puts "x-#{x}, y-#{y}, c-#{c}"
    @board[x][y] = Tile.new(c, "")
  end

  # Writes a line on the board
  # direction = (:right | :down)
  def write_line( x, y, direction, line )
    case direction
    when :down
      (line.size).times {|dx| write_char( x+dx, y, line[dx] )}
    when :right
      (line.size).times {|dy| write_char( x, y+dy, line[dy] )}
    end
  end

  # Returns all the words generated from the board
  #  Goes through the entire board, as a double check against bad inserts
  def all_words
    words = []
    buffer = "" #buffer that reads horizontally
    rbuffer = "" #buffer that reads vertically

    @board.size.times do |a|
      @board[a].size.times do |b|
        buffer << @board[a][b].letter
        rbuffer << @board[b][a].letter
      end

      words << buffer.scan(/(\w{2,})/)
      words << rbuffer.scan(/(\w{2,})/)
      buffer = ""
      rbuffer = ""

    end

    words.delete([])
    words = words.join(", ").split(", ")
    return words

  end

  # Returns a pretty string ready for STDOUT
  #  pp - pretty print, default true
  #  verbose - shows modifier, default false
  def show_board(pp = "true", verbose = "false")
    result = ""
    puts "pp - #{pp}; verbose - #{verbose}"
    @board.each do |tileSet|
      tileSet.each do |tile|

        # show characters or values
        pp == "true" ? result += " #{tile.show_tile}" : result += " #{tile.value}"

        # show the modifer as a character
        verbose == "false" ? result += "" : result += "#{tile.modifier}"

      end
      result += "\n"
    end

    return result
  end


end
