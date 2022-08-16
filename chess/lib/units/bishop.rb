# frozen_string_literal: true

require './lib/unit'

# Represents a King chess piece
class Bishop < Unit
  def initialize(location, player, id = location)
    super(location, player, id)
    @allowed_move_deltas = { standard: bishop_deltas_all_move_types,
                             attack: bishop_deltas_all_move_types }
  end

  private

  def bishop_deltas_all_move_types
    (1..7).reduce([]) { |all, dist| all + [[dist, dist], [dist, -dist], [-dist, dist], [-dist, -dist]] }
  end
end