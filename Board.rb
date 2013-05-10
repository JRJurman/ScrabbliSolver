require "colorize"
require "./Tile.rb"

class Board
  attr_accessor :board

  def initialize( boardFile )
    @board = [[]]
    f = File.open( boardFile )
    f.each_char do |c|
      c != "\n" ? @board[@board.size()-1] << c : @board << []
    end
  end

  def showBoard
    board.each do |tile|
    end
  end
end
