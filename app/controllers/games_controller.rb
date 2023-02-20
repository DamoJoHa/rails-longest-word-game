require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L",
      "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    @letters = []
    10.times do
      @letters.push(alphabet.sample)
    end
  end

  def score
    @word = params[:word]
    @letter_string = params[:letters]
    letters = @letter_string.chars
    @score = 0
    if check_letter(@word, letters)
      @message = "Only use the provided letters!"
    elsif check_word(@word)
      @score = @word.length
      @message = "Well Done!"
    else
      @message = 'Not a valid word!'
    end
  end

  private

  def check_letter(word, letters)
    word.chars.each do |char|
      index = letters.find_index(char.upcase!)
      if index
        letters.delete_at(index)
      else
        return true
      end
    end
    false
  end

  def check_word(word)
    url = 'https://wagon-dictionary.herokuapp.com/'
    response = URI.open("#{url}#{word}").read
    data = JSON.parse(response)
    data['found']
  end
end
