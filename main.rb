require_relative "lib/game"
require 'yaml'

game = Game.new()
save = false
while true
    puts "Would you like to: 1) Start a new game
                            2) Load a game"
    answer = gets.chomp
    if answer == "1"
        save = game.play
        if save
            puts "Enter a name to save your progress"
            name = gets.chomp
            if File.exist? "Data/#{name}.txt"
                puts "This name already exist in our database"
            else
                file = open("Data/#{name}.txt", 'w')
                file.write Marshal.dump(game)
                file.close
            end
            puts "Your progress has been saved"
        end
    elsif answer == "2"
        puts "What is the name you saved?"
        name = gets.chomp

        if File.exist? "Data/#{name}.txt" 
            file = open("Data/#{name}.txt", 'r')
            loaded_game = Marshal.load(file.read)
            loaded_game.play
        else
            puts "This name doesn't exist"
        end

    end
    puts "Do you want to play the game again?[y/n]"
    if gets.chomp == "n"
        break
    end
end

