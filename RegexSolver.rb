class RegexSolver
  def initialize(board, rack=[])

    buffer = ""
    rbuffer = ""
    @regexArray = []
    boardArray = board.board

    boardArray.size.times do |row|
      boardArray[row].size.times do |col|
        buffer << boardArray[row][col].letter
        rbuffer << boardArray[col][row].letter
      end

      @regexArray += [buffer]
      @regexArray += [rbuffer]
      buffer = ""
      rbuffer = ""

    end

    @regexArray.delete(" "*15)
    #print( @regexArray.join(",\n") )
    solve

  end

  def solve

    # prep each line for regex comparison

    @regexArray.each do |line|
      # grab begining spaces
      begSpace = line.match(/^\s*/).to_s.size
      endSpace = line.match(/\s*$/).to_s.size
      characters = line.gsub(/^\s*/, "").gsub(/\s*$/, "").gsub(" ", ".").to_s

      matcher = ".{0,#{begSpace}}#{characters}.{0,#{endSpace}}"
      puts matcher

    end


  end
end
