require "colorize"

class Tile

  attr_accessor :letter, :modifier

  def initialize( letter, modifier )
    @letter = letter
    case modifier
    when "T"
      @modifier = :T
    when "D"
      @modifier = :D
    when "t"
      @modifier = :t
    when "d"
      @modifier = :d
    else
      @modifier = :n
    end
  end

  def show_tile
    case @modifier
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
