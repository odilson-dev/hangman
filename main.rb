require 'open-uri'


url = URI.open('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt')

dirname = "dictionnary"
Dir.mkdir(dirname) unless File.exist? dirname

File.open("#{dirname}/dictionnary.txt", 'w'){ |f| f.write(url.read) } 


dictionnary = File.open("#{dirname}/dictionnary.txt")



puts dictionnary.read

dictionnary.close

