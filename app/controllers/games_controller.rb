require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << [*'A'..'Z'].sample }
    @letters.join("")
  end

  def score
    @letters = params[:letters]
    @letters.split(" ").join("")
    @word = params[:word]
    @word.upcase!
    if @word.chars.all? { |char| @word.count(char) <= @letters.count(char) }
      if english_word?(@word)
        return @answer = "<strong>Congratulations!</strong> #{@word.upcase} is a valid English word!" 
      else
        return @answer = "Sorry but <strong>#{@word.upcase}</strong> does not seem to be a valid English word..."
      end
    else
      return @answer = "Sorry but #{@word.upcase} can't be built out of #{@letters.upcase}"
    end
  end

  def english_word?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    dictionary = JSON.parse(url.read)
    return dictionary['found']
  end

end
