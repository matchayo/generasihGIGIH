class Person
  attr_reader :name, :hitpoint_max, :hitpoint, :attack_damage, :alive

  def initialize(name, hitpoint_max, attack_damage)
    @name = name
    @hitpoint_max = hitpoint_max
    @hitpoint = @hitpoint_max
    @attack_damage = attack_damage
    @alive = true
  end

  def to_s
    return "#@name has #@hitpoint hitpoint and #@attack_damage attack damage."
  end

  def attack(enemy)
    enemy.take_damage(@attack_damage)
    puts attack_s(enemy)
  end

  def attack_s(enemy)
    return "#@name attacks #{enemy.name} with #@attack_damage damage."
  end

  def random_attack(enemies)
    enemy = nil
    if enemies.length() > 1
      max = enemies.length() - 1
      enemy = enemies[rand(0..max)]
    elsif enemies.length() == 1
      enemy = enemies[0]
    end

    if enemy != nil
      self.attack(enemy)

      puts enemy

      if !enemy.alive || enemy.is_a?(Villain) && enemy.flee?
        puts enemy.die if !enemy.alive
        puts enemy.fled if enemy.is_a?(Villain) && enemy.flee?
        enemies.delete(enemy)
      end
    end
    return enemies

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
end