class Turn

  attr_reader :guess

  def initialize
    @guess = []
  end

  def enter_character
    print "Please enter a character : "
    @guess = gets.chomp
    puts @guess
  end

end