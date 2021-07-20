require_relative "hero.rb"

class PlayableCharacter < Hero
    attr_reader :actions

    def initialize(name, hitpoint, attack_damage, deflect = 0, heal_point = 0)
        super(name, hitpoint, attack_damage, deflect, heal_point)
        @actions = ["attack", "heal"]
    end

    def play_turn(heroes, villains)
        action = select_action
        if action == "heal"
            target = select_target(action, heroes)
            heal(target)
        elsif action == "attack"
            target = select_target(action, villains)
            attack(target)
            villains.delete(target) if (target.removed?)
        end
    end

    def select_action
      puts "As #@name, what do you want to do this turn?"
      puts "1) Attack an enemy"
      puts "2) Heal an ally"

      opt = gets.chomp.to_i - 1
      puts "\n"

      @actions[opt]
    end

    def select_target(action, targets)
        puts "Which character do you want to #{action}?"
        for i in 1..targets.length() do
            puts "#{i}) #{targets[i - 1].name}"
        end

        opt = gets.chomp.to_i - 1
        puts "\n"

        selected_target = targets[opt]
    end
end