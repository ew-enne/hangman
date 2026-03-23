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
      file.readlines()[rl - 1]
    end
  end



  def play

    countdown = 8

    word = open_file.chomp
    until (word.length > 4  && word.length < 13)
      # puts word.length
      word = open_file.chomp
    end
    puts "The secret word is: #{word}"

    # initialize the array showing the guesses of the player
    array_result = Array.new(word.length) { '-' }   

    # initialize the array containing the wrong guesses
    array_wrong = []
        
    # transform the random word into an array
    array = word.chars

    while (array_result.include?('-') && countdown > 0)

      # launches a guessing turn
      turn = Turn.new
      puts
      player_entry = turn.enter_character.downcase

      # checks if the entered character is present in the array
      character_present = array.include?(player_entry)
      
      if !character_present
        array_wrong << player_entry
        puts
        puts array_result.join
        puts
        puts "This character is NOT present in the word. Try again!"
      else
        puts
        puts "This character is present in the word."
        array.each_with_index do |letter, index|
          if letter == player_entry
            array_result[index] = player_entry
          end
        end
        puts
        puts array_result.join
      end
      puts

      countdown -= 1
      if countdown > 0
        puts "You have #{countdown} guesses left."
        if !array_wrong.empty?
          puts "Incorrect guesses: #{array_wrong.join}"
        end
      else
        puts "Game over, you don't have any guesses left!"
        exit
      end
    end
    puts "You won!"

  end



end