require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('a'..'z').to_a[rand(26)]}
  end

  def score
    # raise
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    # @simple_letters = 10.times.map { ('a'..'z').to_a[rand(26)]}.join(",")
    @included = include?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def include?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter)}
  end

  def english_word?(word)
    # url = "https://wagon-dictionary.herokuapp.com/#{word}"
    # json = URI.open(url).read
    # @JSON.parse(json)

    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  # def checker(answer_array, grid_array)
  #   if answer_array - grid_array == []
  #     hash = grid_array.tally
  #     answer_array.each { |letter| hash[letter] -= 1 }
  #     hash.select { |_k, v| v.negative? }.empty?
  #   else
  #     false
  #   end
  # end
end
