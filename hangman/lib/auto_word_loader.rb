# frozen_string_literal: true

# Represents a word loader which pulls a random word from a list of words
class AutoWordLoader
  def initialize(filepath)
    @filepath = filepath
  end

  def word
    words.sample
  end

  private

  def words
    unless @words
      lines = File.readlines(@filepath)
      lines.each { |line| @words.push(line) }
    end
    @words
  end

end