require "colorize"

class Tile

  attr_accessor :letter, :multiplier

  def initialize( letter, multiplier )
    @letter = letter
    case multiplier
    when "T"
      @multiplier = :T
    when "D"
      @multiplier = :D
    when "t"
      @multiplier = :t
    when "d"
      @multiplier = :d
    else
      @multiplier = :none
    end
  end

  def show_tile
    case @multiplier
    when :T
      pLetter = "#".red
    when :D
      pLetter = "#".yellow
    when :t
      pLetter = "#".blue
    when :d
      pLetter = "#".cyan
    else
      pLetter = @letter
    end
    
    return pLetter
  end

end
