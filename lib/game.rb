require 'open-uri'
require 'colorize'


url = URI.open('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt')

def find_secret_word(dictionnary)
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
        @guess_renmaining = 10
        @wrong_letters = []
        @word_guessed = Array.new(@secret_word.length, "_")
    end

    

    def play
        10.times do
            @guess_renmaining -= 1
            puts "Guess remaining: #{@guess_renmaining}".light_cyan + " Incorrect letters: #{@wrong_letters.join(" ")}".light_magenta
            puts @word_guessed.join(" ").light_cyan
            puts "Enter a letter"
            answer = gets.chomp.downcase
            puts "\n"
            if answer == "save"
                return "save"
            elsif answer.length != 1 or !letter? answer
                puts "Wrong input".red
                @guess_renmaining += 1
                redo
            elsif @wrong_letters.include? answer
                puts "This letter has already been choosen".light_blue
                next 
            else
                if @secret_word.include? answer
                    puts "Correct !".light_green
                    @secret_word.split("").each_with_index { |value, index| @word_guessed[index] = value if value == answer }
                    if @word_guessed.count("_") == 0
                        puts "You win the game".light_green
                        break
                    end
                else
                    puts "Incorrect !".light_red
                    @wrong_letters << answer
                end
            end
        end
        if @word_guessed.count("_") != 0
            puts "You lose !".light_red
            puts "The word was : " + @secret_word.light_cyan
        end
        
    end

    
end
dictionnary.close