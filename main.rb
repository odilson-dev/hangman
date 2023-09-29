require_relative "lib/game"
require 'colorize'
def show_saved_names
    data_directory = Dir.glob("Data/*.txt")
    data_directory.each { |path| puts File.basename(path).chomp(".txt") }
end

while true
    puts "Would you like to: 1) Start a new game
                   2) Load a game"
    answer = gets.chomp
    if answer == "1"
        game = Game.new()
        game.play
    elsif answer == "2"
        puts "What is the name you saved?"
        show_saved_names
        name = gets.chomp

        if File.exist? "Data/#{name}.txt"
            puts "We found your progress, You can continue where you left off".light_green
            file = open("Data/#{name}.txt", 'r')
            loaded_game = Marshal.load(file.read)
            loaded_game.play
        else
            puts "This name doesn't exist in our database".light_blue
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

