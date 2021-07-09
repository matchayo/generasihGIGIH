require_relative "person.rb"

class Villain < Person
  attr_reader :flee_percentage, :flee

  def initialize(name, hitpoint_max, attack_damage, flee_percentage = 0)
    super(name, hitpoint_max, attack_damage)
    @flee_percentage = flee_percentage.to_f / 100 # Range 0 to 1
    @flee = false
  end

  def take_damage(damage)
    super(damage)

    if @alive && @hitpoint <= 50 && rand() <= @flee_percentage
      @flee = true
    end
  end

  def flee?
    return @flee
  end

  def fled
    return "#@name has fled the battlefield with #@hitpoint hitpoint left."
  end
end