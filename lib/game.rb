require 'open-uri'
require 'colorize'
require 'json'

url = URI.open('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt')

def find_@secret_word(dictionnary)
    dictionnary.readlines.map{ |word| word.chomp("\n") if (5..12).to_a.include? word.chomp("\n").length }.compact.sample
 end

def letter?(lookAhead)
    lookAhead.match?(/[[:alpha:]]/)
end

dirname = "dictionnary"
Dir.mkdir(dirname) unless File.exist? dirname

File.open("#{dirname}/dictionnary.txt", 'w'){ |f| f.write(url.read) } 

data = "Data"
Dir.mkdir(data) unless File.exist? data


dictionnary = File.open("#{dirname}/dictionnary.txt")
class Game
    def initialize
    @secret_word = "condition"

    @guess_renmaining = 15
    @wrong_letters = []
    @word_guessed = Array.new(@secret_word.length, "_")

    def play
        @guess_renmaining.times do
            @guess_renmaining -= 1
            puts "Guess remaining: #{@guess_renmaining}" + " Incorrect letters: #{@wrong_letters.join(" ")}"
            puts @word_guessed.join(" ")
            puts "Enter a letter"
            answer = gets.chomp.downcase
            puts "\n"
            if answer == "save"
                puts "Enter a name to save your progress"
                @name = gets.chomp
                serialized_player = JSON.dump(self)
                file = open("#{@name}.json", "w")
                file.write serialized_player
                puts "Your progress has been saved"
                break
            elsif answer.length != 1 or !letter? answer
                puts "wrong input".red
                redo
            elsif @wrong_letters.include? answer
                puts "This letter has already been choosen".red
                redo 
            else
                if @secret_word.include? answer
                    @secret_word.split("").each_with_index { |value, index| @word_guessed[index] = value if value == answer }
                    if @word_guessed.count("_") == 0
                        puts "You win the game".green
                        break
                    end
                else
                    @wrong_letters << answer
                end
            end
        end
    
        dictionnary.close
    end

    
end