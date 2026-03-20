# internal files
require_relative 'turn'

class Game
  
  def random_line
    total_lines = 9694
    rand(1..total_lines)
  end

  def open_file
    file_name = "google-10000-english-no-swears.txt"
    File.open(file_name, "r") do |file|      
      rl = random_line
      puts rl
      puts file.readlines()[rl - 1]
      puts rl
    end
  end

  def play
    turn = Turn.new
    turn.enter_character
  end



end