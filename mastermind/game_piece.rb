# frozen_string_literal: true

require 'colorize'

# Represents a color
class GamePiece
  attr_reader :color

  COLORS = { red: { id: 0, abbrev: 'R', text_color: :white },
             cyan: { id: 1, abbrev: 'C', text_color: :black },
             yellow: { id: 2, abbrev: 'Y', text_color: :black },
             green: { id: 3, abbrev: 'G', text_color: :black },
             blue: { id: 4, abbrev: 'B', text_color: :white },
             magenta: { id: 5, abbrev: 'M', text_color: :white } }.freeze

  def initialize(color)
    @color = self.class.check_color(color)
  end

  def self.check_color(color)
    unless COLORS.include?(color)
      raise ArgumentError, "Color must be red, cyan, yellow, green, blue, or magenta. Value: #{color}"
    end

    color
  end

  def self.from_id(id)
    new(COLORS.find { |_color, values| values[:id] == id }.first)
  end

  def self.from_abbrev(abbrev)
    p abbrev
    new(COLORS.find { |_color, values| values[:abbrev] == abbrev.upcase }.first)
  end

  def id
    COLORS[color][:id]
  end

  def abbrev
    COLORS[color][:abbrev]
  end

  def text_color
    COLORS[color][:text_color]
  end

  def display
    " #{color_abbrev} ".colorize(background: color, color: text_color)
  end
end
