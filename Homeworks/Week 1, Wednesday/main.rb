#require_relative "person.rb"
#require_relative "villain.rb"
require_relative "hero.rb"
require_relative "archer.rb"
require_relative "spearman.rb"
require_relative "swordsman.rb"

# Heroes
jin = Hero.new("Jin Sakai", 100, 50, 0.8, 20)
yuna = Hero.new("Yuna", 90, 45)
sensei = Hero.new("Sensei Ishikawa", 80, 60)
heroes = [jin, yuna, sensei]

# Villains
m_arch = Archer.new("Mongol Archer", 80, 40, 50)
m_spear = Spearman.new("Mongol Spearman", 120, 60, 50)
m_sword = Swordsman.new("Mongol Swordsman", 100, 50, 50)
villains = [m_arch, m_spear, m_sword]

turn = 1

until !jin.alive
  puts "======== Turn #{turn} ========"
  # Hitpoints and attack damage information
  puts "\n"
  puts heroes

  puts "\n"
  puts villains

  puts "\n"
  puts "As Jin Sakai, what do you want to do this turn?"
  puts "1) Attack an enemy"
  puts "2) Heal an ally"
  opt = gets.chomp.to_i

  puts "\n"

  # Attack
  if opt == 1
    puts "Which enemy you want to attack?"
    for i in 1..villains.length() do
      puts "#{i}) #{villains[i - 1].name}"
    end

    opt = gets.chomp.to_i - 1
    puts"\n"

    jin.attack(villains[opt])
    puts villains[opt]
    puts "\n"

    if !villains[opt].alive || villains[opt].flee?
      villains.delete(villains[opt])
    end

  #Heal
  elsif opt == 2
    puts "Which ally you want to heal?"
    for i in 0..heroes.length() - 1 do
      if heroes[i] != jin
        puts "#{i}) #{heroes[i].name}"
      end
    end

    opt = gets.chomp.to_i
    puts"\n"
    jin.heal(heroes[opt])
    puts heroes[opt]
    puts "\n"
  end

  # Heroes attack randomly
  for i in 0..heroes.length() - 1 do
    if heroes[i] != jin
      villains = heroes[i].random_attack(villains)
      puts "\n"

      break if villains.empty?
    end
  end

  break if villains.empty?
  break if heroes.empty?

  # Villains attack randomly
  for i in 0..villains.length() - 1 do
    heroes = villains[i].random_attack(heroes)
    puts "\n"

    break if heroes.empty? and !jin.alive
  end

  turn += 1
end

if jin.alive
  puts "JIN WINS."
elsif !villains.empty?
  puts "JIN LOSES."
end
