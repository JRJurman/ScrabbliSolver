require "colorize"

class Tile

  attr_accessor :letter, :modifier, :value
  @@vLookUp = {
    'A'=> 1, 'B'=> 3, 'C'=> 3, 'D'=> 2, 'E'=> 1, 'F'=> 4, 
    'G'=> 2, 'H'=> 4, 'I'=> 1, 'J'=> 8, 'K'=> 5, 'L'=> 1, 
    'M'=> 3, 'N'=> 1, 'O'=> 1, 'P'=> 3, 'Q'=> 10,'R'=> 1, 
    'S'=> 1, 'T'=> 1, 'U'=> 1, 'V'=> 4, 'W'=> 4, 'X'=> 8, 
    'Y'=> 4, 'Z'=> 10,' '=> 0
  }

  def initialize( letter, modifier, value=-1 )
    @letter = letter
    value == -1 ? @value=@@vLookUp[@letter] : @value = value
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
