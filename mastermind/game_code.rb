# frozen_string_literal: true

require_relative 'game_piece'

# Represents a game code
class GameCode
  attr_reader :code
  def initialize(code)
    @code = if code.all? { |item| !Integer(item, exception: false).nil? && item.to_i.digits.count == 1}
              code.map { |item| GamePiece.from_id(item.to_i) }
            elsif code.all? { |item| item.is_a?(String) && item.length == 1 }
              code.map { |item| item && GamePiece.from_abbrev(item) }
            else
              raise ArgumentError, 'Code must be array of single digit integers or characters'
            end
  end

  def values
    @code.map(&:id)
  end

  def display
    @code.map(&:display).join(' ')
  end
end
