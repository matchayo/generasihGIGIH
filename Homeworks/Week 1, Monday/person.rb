class Person
  attr_reader :name, :hitpoint, :attack_damage, :deflect, :alive

  def initialize(name, hitpoint, attack_damage, deflect = 0)
    @name = name
    @hitpoint = hitpoint
    @attack_damage = attack_damage
    @deflect = deflect
    @alive = true
  end

  def to_s
    return "#{@name} has #{@hitpoint} hit points and #{@attack_damage} attack damage.\n\n"
  end

  def attack(other_person)
    hit = other_person.take_damage(@attack_damage)
    if hit
      puts "#{@name} attacks #{other_person.name} with #{@attack_damage} damage."
    else
      puts "#{other_person.name} deflects #{@name}'s attack."
    end

    puts "#{other_person.name} has #{other_person.hitpoint} hitpoints and #{other_person.attack_damage} attack damage.\n\n"
  end

  def take_damage(damage)
    hit = rand()

    if hit > deflect
      @hitpoint -= damage

      if @hitpoint <= 0
        @alive = false
      end

      return true
    end
  end
end
