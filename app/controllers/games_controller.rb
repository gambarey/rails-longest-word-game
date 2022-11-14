require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end
  def score
    @word = params[:word].upcase
    @score = 0
    def included?(word, grid)
      word.chars.all? { |letter| word.count(letter) <= word.count(letter) }
    end
    def english_word?
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
      json = JSON.parse(response.read)
      return json['found']
    end

    if !included?(@word, @letters)
    @message = "Not in the grid"
    else
     if english_word?
      @score += params[:word].length.to_i
      @message = "Your score is #{@score}"
       else
      @message = "Sorry, #{@word} is not an english word"
      end
      # @message = "Not in the grid"
    end
    end
  end
