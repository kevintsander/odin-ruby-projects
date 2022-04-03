# frozen_string_literal: true

require 'colorize'

# Represents a color
class GamePiece
  attr_reader :color

  COLORS = { red: { id: 0, abbrev: 'R', text_color: :white },
             orange: { id: 1, abrrev: 'O', text_color: :black },
             yellow: { id: 2, abbrev: 'Y', text_color: :black },
             green: { id: 3, abbrev: 'G', text_color: :black },
             blue: { id: 4, abbrev: 'B', text_color: :white },
             magenta: { id: 5, abbrev: 'M', text_color: :white } }.freeze

  def self.check_color(color)
    unless COLORS.include?(color)
      raise ArgumentError, "Color must be red, orange, yellow, green, blue, or magenta. Value: #{color}"
    end

    color
  end

  def self.piece_by_color_id(id)
    new(COLORS.find { |_color, values| values[:id] == id }.first)
  end

  def self.piece_by_color_abbrev(abbrev)
    new(COLORS.find { |_color, values| values[:abbrev] == abbrev }.first)
  end

  def initialize(color)
    @color = self.class.check_color(color)
  end

  def color_id
    COLORS[color][:id]
  end

  def color_abbrev
    COLORS[color][:abbrev]
  end

  def color_text_color
    COLORS[color][:text_color]
  end

  def color_display
    " #{color_abbrev} ".colorize(background: color, color: color_text_color)
  end
end
