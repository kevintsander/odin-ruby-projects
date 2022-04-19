# frozen_string_literal: true

require_relative 'code_scorer'

# Represents a code score
class CodeScore
  extend CodeScorer
  attr_reader :full, :partial

  def initialize(full = 0, partial = 0)
    @full = full
    @partial = partial
  end

  def calculate(code, guess)
    score = CodeScorer.calculate(code.values, guess.values)
    @full = score[0]
    @partial = score[1]
    self
  end

  def values
    [@full, @partial]
  end

  def text
    values.to_s
  end
end
