class Game
  attr_reader :playable_char, :nonplayable_char

  def initialize(playable_char)
    @playable_char = playable_char
    @nonplayable_char = {
      heroes: [],
      villains: []
    }
  end

  def add_hero(hero)
    @nonplayable_char[:heroes] << hero
  end

  def add_villain(villain)
    @nonplayable_char[:villains] << villain
  end

  def start_game
    until (@playable_char.die? || @nonplayable_char[:villains].empty?) do
      puts "========================================================"
      print_characters_stats
      puts "\n"

      play_characters_turn
    end

    game_ends
  end

  def print_characters_stats
    @playable_char.print_stats
    @nonplayable_char.each_value do |group|
      group.each do |person|
        person.print_stats
      end
    end
  end

  def play_characters_turn
    @playable_char.play_turn(@nonplayable_char[:heroes], @nonplayable_char[:villains])

    @nonplayable_char.each do |group, people|
      people.each do |person|
        if group == :heroes
          targets = @nonplayable_char[:villains]
          unless targets.empty?
            target = targets[rand(targets.size)]
            person.attack(target)
            targets.delete(target) if target.removed?
          end
        elsif group == :villains
          targets = @nonplayable_char[:heroes].dup
          targets << @playable_char
          unless targets.empty?
            target = targets[rand(targets.size)]
            person.attack(target)
            @nonplayable_char[:heroes].delete(target) if target.removed?
          end
        end
      end
    end

    puts "\n"
  end

  def game_ends
    if @playable_char.die?
      puts "#{@playable_char.name} lost."
    elsif@nonplayable_char[:villains].empty?
      puts "#{@playable_char.name} won."
    end
  end
end