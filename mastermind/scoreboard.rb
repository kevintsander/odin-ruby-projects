# frozen_string_literal: true

# Conatains all the previous score and game info
class ScoreBoard
  attr_reader :board

  def initialize
    @board = []
  end

  def add(code, score)
    @board.push({code: code, score: score})
  end

  def refresh
    @board.clear
  end

  def last_score
    @board.last[:score]
  end

  def last_code
    @board.last[:code]
  end

  def empty?
    @board.empty?
  end

  def scores
    @board.map { |item| item[:score] } || []
  end

  def codes
    @board.map { |item| item[:code] } || []
  end

  def code_values
    codes.map { |code| code.values } || []
  end

  def score_values
    scores.map { |score| score.values } || []
  end

  def last_code_score_text
    last = @board.last
    "Guess: #{last[:code].text} Score: #{last[:score].text}"
  end
end