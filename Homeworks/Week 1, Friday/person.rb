class Person
  attr_reader :name, :hitpoint_max, :hitpoint, :attack_damage, :alive

  def initialize(name, hitpoint_max, attack_damage)
    @name = name
    @hitpoint_max = hitpoint_max
    @hitpoint = @hitpoint_max
    @attack_damage = attack_damage
    @alive = true
  end

  def print_stats
    puts "#@name has #@hitpoint hitpoint and #@attack_damage attack damage."
  end

  def attack(enemy)
    enemy.take_damage(@attack_damage)
    puts attack_s(enemy)
  end

  def attack_s(enemy)
    return "#@name attacks #{enemy.name} with #@attack_damage damage."
  end

  def take_damage(damage)
    @hitpoint -= damage

    if @hitpoint <= 0
      @alive = false
    end
  end

  def die
    return "#@name dies."
  end

  def die?
    !@alive
  end

  def removed?
    die?
  end
end