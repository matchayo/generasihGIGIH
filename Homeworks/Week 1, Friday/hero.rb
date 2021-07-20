require_relative "person.rb"

class Hero < Person
  attr_reader :deflect, :heal_point

  def initialize(name, hitpoint_max, attack_damage, deflect = 0, heal_point = 0)
    super(name, hitpoint_max, attack_damage)
    @deflect = deflect
    @heal_point = heal_point
  end

  def heal(ally)
    ally.take_heal(@heal_point)
    puts "#@name heals #{ally.name}, restoring #@heal_point hitpoints."
  end

  def take_heal(heal_point)
    @hitpoint += heal_point

    if @hitpoint > @hitpoint_max
      @hitpoint = @hitpoint_max
    end
  end

end