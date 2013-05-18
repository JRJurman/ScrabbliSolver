class RegexSolver

  def initialize(scrabbBoard, rack=[], wordLookUp)

    buffer = ""
    rbuffer = ""

    # array of valid rows and columns to write on
    @regexArray = []

    boardArray = scrabbBoard.board

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
    @regexArray.delete("")
    #puts @regexArray.join(",\n")
    #puts @regexArray 

    perArray = rack + @regexArray.join('').split('')
    perArray = perArray.uniq
    puts perArray

    # dictionary of words that can be made with the
    # given board and rack
    @perLookUp = wordLookUp.genSubset(perArray)
    puts @perLookUp

    #solve

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
