class RegexSolver

  def initialize(scrabbBoard, rack=[], wordLookUp)

    @rack = rack
    print @rack

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
    #puts @regexArray.join("\n")
    #puts @regexArray 

    perArray = rack + @regexArray.join('').split('')
    perArray = perArray.uniq
    #puts perArray

    # dictionary of words that can be made with the
    # given board and rack
    @perLookUp = wordLookUp.genSubset(perArray)
    #puts @perLookUp

    solve

  end

  def solve

    rSols = []
    @regexArray.each do |line|
      # strip line so that we can append regex modifiers
      begSpace = line.match(/^\s*/).to_s.size
      endSpace = line.match(/\s*$/).to_s.size
      characters = line.gsub(/^\s*/, "").gsub(/\s*$/, "").gsub(" ", ".").to_s

      # format the regex and put our rack on it
      matcher = "^.{0,#{begSpace}}#{characters}.{0,#{endSpace}}$"
      matcher.gsub!(".", "[#{@rack.join()}]")
      #puts matcher

      # look through every word in our look up,
      # and see which words will match with our matcher
      sols = []
      @perLookUp.each do |word|
        if word.match(/#{matcher}/)
          sols << word
        end
      end

      # validate words considering how many of each letter we have
      sols.each do |word|
        # Resource of both rack and board tiles for this word
        resource = @rack + line.split('')
        resource.delete(' ')
        #print resource
        m = 0 # our wildcard counter... for later ...
        word.each_char do |letter|
          resource.include?(letter) ? resource.delete(letter) : m -= 1
        end
        if m == 0
          rSols << word
        end
      end

    end
    rSols.sort! {|x, y| x.size <=> y.size}
    puts rSols


  end
end
