require_relative "lib/game"
require 'colorize'

game = Game.new()
save = false
while true
    puts "Would you like to: 1) Start a new game
                             2) Load a game"
    answer = gets.chomp
    if answer == "1"
        save = game.play
        if save == "save"
            while true
                puts "Enter a name to save your progress"
                name = gets.chomp
                if File.exist? "Data/#{name}.txt"
                    puts "This name already exist in our database, please choose another name".light_blue
                    redo
                else
                    file = open("Data/#{name}.txt", 'w')
                    file.write Marshal.dump(game)
                    file.close
                    puts "Your progress has been saved!".light_green
                    break
                end
                
            end
        end
    elsif answer == "2"
        puts "What is the name you saved?"
        name = gets.chomp

        if File.exist? "Data/#{name}.txt"
            puts "We found your progress, You can continue where you left off".light_green
            file = open("Data/#{name}.txt", 'r')
            loaded_game = Marshal.load(file.read)
            loaded_game.play
        else
            puts "This name doesn't exist".light_blue
        end
    else
        puts "Choose 1 or 2"
        redo
    end
    puts "Do you want to play the game again?[y/n]"
    if gets.chomp == "n"
        break
    end
end

