require 'open-uri'
require 'colorize'

module SecretWord
    url = URI.open('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt')

    dirname = "dictionnary"
    Dir.mkdir(dirname) unless File.exist? dirname
    dictionnary = File.open("#{dirname}/dictionnary.txt")
    File.open("#{dirname}/dictionnary.txt", 'w'){ |f| f.write(url.read) } 
    dictionnary.close

    def find_secret_word
        dictionnary = File.open("dictionnary/dictionnary.txt", "r" )
        secret_word = dictionnary.readlines.map{ |word| word.chomp("\n") if (5..12).to_a.include? word.chomp("\n").length }.compact.sample
        dictionnary.close
        secret_word
    end
    
end


def letter?(lookAhead)
    lookAhead.match?(/[[:alpha:]]/)
end



data = "Data"
Dir.mkdir(data) unless File.exist? data



class Game
    include SecretWord
    
    def initialize
        @secret_word = find_secret_word
        @guess_renmaining = 10
        @wrong_letters = []
        @word_guessed = Array.new(@secret_word.length, "_")
    end

    

    def play
        while @guess_renmaining > 0
            puts "Guess remaining: #{@guess_renmaining}".light_cyan + " Incorrect letters: #{@wrong_letters.join(" ")}".light_magenta
            puts @word_guessed.join(" ").light_cyan
            puts "Enter a letter"
            answer = gets.chomp.downcase
            puts "\n"
            if answer == "save"
                puts "What is the name to save your progress on?"
                name = gets.chomp
                file = open("Data/#{name}.txt", 'w')
                file.write Marshal.dump(self)
                file.close
                puts "Your progress has been saved!".light_green
                return
            elsif answer.length != 1 or !letter? answer
                puts "Wrong input".red
                redo
            elsif @wrong_letters.include? answer
                puts "This letter has already been choosen".light_blue
                redo
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
                @guess_renmaining -= 1
            end
        end
        if @word_guessed.count("_") != 0
            puts "You lose !".light_red
            puts "The word was : " + @secret_word.light_cyan
        end
        
    end

    
end