# internal files
require_relative 'turn'

class Game

  def initialize
    @countdown = 0
    @array = []
    @array_result = []
    @array_wrong = []
    @character_present = false
    @player_entry = ""
  end

  def play

    ####### option to load a saved game ######
    puts
    print "Would you like to load a saved game (y/n)? "
    player_choice = gets.chomp

    if player_choice == "y" ### start with a saved game
      load_saved_game

    else ### start with a new game
      puts
      puts "Ok, so let's start a new game."
      @countdown = 8

      word = open_file.chomp
      until (word.length > 4  && word.length < 13)
        word = open_file.chomp
      end

      # transform the random word into an array
      @array = word.chars

      # initialize the array showing the guesses of the player
      @array_result = Array.new(word.length) { '-' }

      # initialize the array containing the wrong guesses
      @array_wrong = []
    end

    while (@array_result.include?('-') && @countdown > 0)

      ####### option to save a game ######
      puts
      print "Would you like to save the game (y/n)? "
      save_choice = gets.chomp

      if save_choice == "y" ### save the game
        save_game

      else ### continue the game
        # launches a guessing turn
        turn = Turn.new
        puts
        @player_entry = turn.enter_character.downcase

        # checks if the entered character is present in the array
        @character_present = @array.include?(@player_entry)        
        check_character
      end

      @countdown -= 1
      check_win
    end
    puts "You won!"

  end

  private
  
  def random_line
    total_lines = 9694
    rand(1..total_lines)
  end

  def open_file
    file_name = "google-10000-english-no-swears.txt"
    File.open(file_name, "r") do |file|
      rl = random_line
      file.readlines()[rl - 1]
    end
  end

  def save_game
    puts
        File.open("game.txt", "w") do |game_file|
          game_file.puts @countdown.to_s
          game_file.puts @array.join
          game_file.puts @array_result.join
          game_file.puts @array_wrong.join
        end
        exit
  end

  def load_saved_game
    puts
      File.open("game.txt", "r") do |game_file|
        @countdown = game_file.readline().to_i # the saved remaining turns
        @array = game_file.readline().chomp.chars # the array with selected random word
        @array_result = game_file.readline().chomp.chars # the array with the saved correct characters
        @array_wrong = game_file.readline().chomp.chars # the array with the saved wrong characters
      end
      puts "Here are your saved guesses: #{@array_result.join}"
      puts "Here are your wrong guesses: #{@array_wrong.join}"
      puts "You have #{@countdown} turns left"
  end

  def check_character
    if !@character_present
      @array_wrong << @player_entry
      puts
      puts @array_result.join
      puts
      puts "This character is NOT present in the word. Try again!"
    else
      puts
      puts "This character is present in the word."
      @array.each_with_index do |letter, index|
        if letter == @player_entry
          @array_result[index] = @player_entry
        end
      end
      puts
      puts @array_result.join
    end
    puts
  end

  def check_win
    if @countdown > 0
      puts "You have #{@countdown} guesses left."
      if !@array_wrong.empty?
        puts "Incorrect guesses: #{@array_wrong.join}"
      end
    else
      puts "Game over, you don't have any guesses left!"
      puts "The secret word was: #{@array.join}"
      exit
    end
  end

end