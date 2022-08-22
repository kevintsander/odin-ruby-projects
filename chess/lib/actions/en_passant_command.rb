# frozen_string_literal: true

require './lib/actions/action_command'

# represents an en passant move
class EnPassantCommand < ActionCommand
  def perform_action
    captured_unit = board.unit_at(location, [-1 * 0.send(unit.forward, 1), 0])
    unit.move(location)
    captured_unit.capture
    @captured_unit = captured_unit
  end
end