class Turn

  attr_reader :guess

  def initialize
    @guess = []
  end

  def enter_character
    print "Please enter a character (from a - z): "
    @guess = gets.chomp
  end
  

end