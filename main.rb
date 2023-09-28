require 'open-uri'


url = URI.open('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt')

def find_secret_word(dictionnary)
    dictionnary.readlines.map{ |word| word.chomp("\n") if (5..12).to_a.include? word.chomp("\n").length }.compact.sample
 end

dirname = "dictionnary"
Dir.mkdir(dirname) unless File.exist? dirname

File.open("#{dirname}/dictionnary.txt", 'w'){ |f| f.write(url.read) } 


dictionnary = File.open("#{dirname}/dictionnary.txt")



p find_secret_word(dictionnary)
dictionnary.close

