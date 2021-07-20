require_relative "villain.rb"

class Archer < Villain
  def attack_s(enemy)
    return "#@name shoots an arrow at #{enemy.name} with #@attack_damage damage."
  end
end