require_relative "villain.rb"

class Spearman < Villain
  def attack_s(enemy)
    return "#@name thrusts #{enemy.name} with #@attack_damage damage."
  end
end