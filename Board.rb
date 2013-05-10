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
  # direction = (:right | :down)
  def write_line( x, y, direction, line )
    case direction
    when :down
      (line.size+x).times {|dx| write_char( x+dx, y, line[dx] )}
    when :right
      (line.size+y).times {|dy| write_char( x, y+dy, line[dy] )}
    end
  end

  # Returns all the words generated from the board
  #  Goes through the entire board, as a double check against bad inserts
  def all_words
    words = []
    buffer = ""
    rbuffer = ""

    @board.size.times do |a|
      puts("########### #{@board[a]} ##########")
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
    puts words
    return words

  end

  # Returns a pretty string ready for STDOUT
  def show_board
    result = ""
    @board.each do |tileSet|
      tileSet.each do |tile|
        result += " #{tile.show_tile}"
      end
      result += " \n"
    end
    return result
  end

end
