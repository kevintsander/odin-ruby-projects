# frozen_string_literal: true

require_relative 'code_scorer'

# Contains AI logic for making AI guesses based on the Knuth algorith
class KnuthAI
  extend CodeScorer

  class << self
    # Returns a list of codes that are eliminated if their score
    # does not give the same response if the guess were the code
    def eliminated_codes(codes, guess_code, guess_score)
      codes.dup.reject do |code|
        CodeScorer.calculate(code, guess_code) == guess_score
      end
    end
  end

  def initialize(code_length, code_options, scoreboard)
    @code_length = code_length
    @code_options = code_options
    @scoreboard = scoreboard

    @all_possible_codes = all_possible_codes
    @possible_codes_with_scores = possible_codes_with_scores
    refresh
  end

  def refresh
    @current_possible_codes = @all_possible_codes.dup
  end

  def guess
    if @scoreboard.empty?
      @all_possible_codes.sample
    else
      best_guess
    end
  end

  private

  def eliminate_possible_codes!(guess_code, guess_score)
    @current_possible_codes -= self.class.eliminated_codes(@current_possible_codes, guess_code, guess_score)
  end

  def possible_scores
    possible_scores = []
    (0..@code_length).each do |exact_matches|
      (0..(@code_length - exact_matches)).each do |partial_matches|
        possible_scores.push([exact_matches, partial_matches])
      end
    end
    possible_scores -= [[@code_length - 1, 1]] # [3, 1] is not possible - remove it for efficiency
  end

  def unused_codes
    @all_possible_codes - @scoreboard.codes.map { |code| code.values }
  end

  def possible_codes_with_scores
    @all_possible_codes.product(possible_scores)
  end

  def best_guesses
    # get the list of unused scores (pre-compiled with all possible scores)
    unused_codes_with_scores = @possible_codes_with_scores.reject do |code_score|
      @scoreboard.codes.any? { |code| code.values == code_score[0] }
    end
    # group codes by the amount they will eliminate from possible codes
    hit_count_group = unused_codes_with_scores.group_by do |code_score|
      self.class.eliminated_codes(@current_possible_codes, code_score[0], code_score[1]).size
    end
    # get the group with the most eliminated, then extract the codes
    hit_count_group.max.last.map { |best_code_score| best_code_score[0] }
  end

  def best_guess
    eliminate_possible_codes!(@scoreboard.last_code.values, @scoreboard.last_score.values)

    best = best_guesses
    best_in_possible = best & @current_possible_codes

    # try to take the best guess from list of current possible codes, otherwise just pick a random unused
    if best_in_possible.any?
      best_in_possible.sample
    else
      best_guesses.sample
    end
  end

  def all_possible_codes
    [*1..@code_options].repeated_permutation(@code_length).to_a
  end
end
