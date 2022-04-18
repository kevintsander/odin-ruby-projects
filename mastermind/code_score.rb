# frozen_string_literal: true

require_relative 'code_scorer'

# Represents a code score
class CodeScore
  include CodeScorer
  attr_reader :full, :partial

  def initialize(full = 0, partial = 0)
    @full = full
    @partial = partial
  end

  def calculate(code, guess)
    score = CodeScorer.calculate(code, guess)
    @full = score[0]
    @partial = score[1]
    self
  end

  def values
    [@full, @partial]
  end
end
