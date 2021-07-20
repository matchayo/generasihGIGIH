require_relative "villain.rb"

class Swordsman < Villain
  def attack_s(enemy)
    return "#@name slashes #{enemy.name} with #@attack_damage damage."
  end
end