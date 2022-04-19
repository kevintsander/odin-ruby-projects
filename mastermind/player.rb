# frozen_string_literal: true

require_relative 'game_code'

# Represents a player in the game
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

# Represents a computer player
class ComputerPlayer < Player
  NAMES = %w[Bob Steve George Kate Ashley Rick Stacy Kelly Ken Tony].freeze

  def initialize(name, ai)
    super(name)
    @name = name || NAMES.sample
    @ai = ai
  end

  def create_code
    @ai.create_code
  end

  def guess
    @ai.guess
  end

  def refresh_ai
    @ai.refresh
  end

end

# Represents a human player
class HumanPlayer < Player
  def create_code
    code = ask('> ') { |entry| entry.echo = '*'}
    code_input_to_array(code)
  end

  def guess
    create_code
  end

  private

  def code_input_to_array(string)
    string.gsub(/\s+/, '').split('')
  end

end
