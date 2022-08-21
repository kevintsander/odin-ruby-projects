# frozen_string_literal: true

module GameStatusChecker
  def check?(king)
    king.is_a?(King) && board.enemy_can_attack_location?(king, king.location)
  end

  def checkmate?(king)
    king.is_a?(King) & check?(king) & !allowed_actions(king)&.any?
  end

  def stalemate?(king)
    return false unless king.is_a?(King)
    return false if check?(king)
    return false if board.friendly_units(king).any? { |unit| allowed_actions(unit)&.any? }

    true
  end
end