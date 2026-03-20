# internal files
require_relative 'turn'

class Game
  def play
    turn = Turn.new
  turn.enter_character
  end
end