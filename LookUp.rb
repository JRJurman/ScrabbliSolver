class LookUp

  attr_accessor :dictionaryArray

  # creates a LookUp object using a dictionary File
  def initialize( dictionaryFile )
    @dictionaryArray = []
    f = File.open(dictionaryFile)
    f.each_line do |word|
      @dictionaryArray << word.chomp
    end
  end

  # generate a subset of words that can be made from a list of characters
  def genSubset( charList )
    res = []
    @dictionaryArray.each do |word|
      if word.match(/^[#{charList.join('')}]*$/)
        res << word
      end
    end

    return res
  end

  # checks every word in a list to check if all the words are valid
  #  can be used on a single word by wrapping the word in [ ]
  def valid_check( wordList )

    wordList.each do |word|
      if @dictionaryArray.index(word) == nil
        return false
      end
    end

    return true
  end

end
