# frozen_string_literal: true

require_relative 'code_scorer'

# Contains logic for AI guesses
# 1. Create the set S of 1,296 possible codes (1111, 1112 ... 6665, 6666)
# 2. Start with initial guess 1122 (Knuth gives examples showing that this algorithm 
#    using other first guesses such as 1123, 1234 does not win in five tries on every code)
# 3. Play the guess to get a response of coloured and white pegs.
# 4. If the response is four colored pegs, the game is won, the algorithm terminates.
# 5. Otherwise, remove from S any code that would not give the same response if it (the guess) were the code.
# 6. Apply minimax technique to find a next guess as follows: 
#      - For each possible guess, that is, any unused code of the 1,296 not just those in S, 
#        calculate how many possibilities in S would be eliminated for each possible colored/white peg score. 
#      - The score of a guess is the minimum number of possibilities it might eliminate from S. 
#      - A single pass through S for each unused code of the 1,296 will provide a hit count for each coloured/white peg score found; 
#        the coloured/white peg score with the highest hit count will eliminate the fewest possibilities; 
#        calculate the score of a guess by using "minimum eliminated" = "count of elements in S" - (minus) "highest hit count". 
#        From the set of guesses with the maximum score, select one as the next guess, choosing a member of S whenever possible. 
#        (Knuth follows the convention of choosing the guess with the least numeric value e.g. 2345 is lower than 3456. 
#         Knuth also gives an example showing that in some cases no member of S will be among the highest scoring guesses 
#         and thus the guess cannot win on the next turn, yet will be necessary to assure a win in five.)
# 7. Repeat from step 3.
class KnuthAI
  extend CodeScorer

  class << self
    def eliminated_codes(codes, guess_code, guess_score)
      codes.dup.reject do |code|
        CodeScorer.calculate(code, guess_code) == guess_score
      end
    end
  end

  def initialize(code_length, code_options)
    @code_length = code_length
    @code_options = code_options

    @all_possible_codes = all_possible_codes
    @unused_codes_all_scores = possible_codes_all_scores
    refresh
  end

  def guess(last_score = [0, 0])
    guess = if @guessed_codes.empty?
              @all_possible_codes.sample
            else
              best_guess(last_score)
            end
    update_guesses!(guess)
    guess
  end

  def update_guesses!(guess)
    @guessed_codes.push(guess)
    @unused_codes_all_scores.delete_if { |code_score| code_score[0] == guess }
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
    @all_possible_codes - @guessed_codes
  end

  def possible_codes_all_scores
    @all_possible_codes.product(possible_scores)
  end

  def eliminate_codes!(guess_code, guess_score)
    @current_possible_codes -= self.class.eliminated_codes(@current_possible_codes, guess_code, guess_score)
  end

  def curent_best_guesses
    hit_count_group = @unused_codes_all_scores.group_by do |code_score|
      @current_possible_codes.size - self.class.eliminated_codes(@current_possible_codes, code_score[0], code_score[1]).size
    end
    best_code_scores = hit_count_group.min.last
    best_code_scores.map { |best_code_score| best_code_score[0] }
  end

  def best_guess(last_score)
    eliminate_codes!(@guessed_codes.last, last_score)

    best_guesses = curent_best_guesses
    best_in_possible = best_guesses & @current_possible_codes

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

  def refresh
    @current_possible_codes = @all_possible_codes.dup
    @guessed_codes = []
  end
end
