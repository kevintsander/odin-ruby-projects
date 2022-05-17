# frozen_string_literal: true

class WordLoader
  def initialize(filepath)
    @filepath = filepath
  end

  def random_word
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