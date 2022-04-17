# frozen_string_literal: true

# Represents a score for a code
module CodeScorer
  def item_exact_match?(code_ids, value, index)
    code_ids[index] == value
  end

  def item_exists?(code_ids, value)
    code_ids.any? { |code_value| code_value == value }
  end

  def calculate(code, guess)
    size = code.size
    check_code = code.dup
    check_guess = guess.dup
    
    (check_code.size - 1).downto(0) do |index|
      if check_code[index] == check_guess[index]
        check_code.delete_at(index)
        check_guess.delete_at(index)
      end
    end
    full_matches = size - check_code.size

    (check_code.size - 1).downto(0) do |index|
      check_item = check_code[index]
      if (partial_index = check_guess.index(check_item))
        check_code.delete_at(index)
        check_guess.delete_at(partial_index)
      end
    end
    partial_matches = size - full_matches - check_code.size
    [full_matches, partial_matches]
  end
end
