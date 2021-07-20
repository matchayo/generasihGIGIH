require_relative "hero.rb"
require_relative "playable_character.rb"
require_relative "archer.rb"
require_relative "spearman.rb"
require_relative "swordsman.rb"
require_relative "game.rb"

# Heroes
jin = PlayableCharacter.new("Jin Sakai", 100, 50, 0.8, 20)
yuna = Hero.new("Yuna", 90, 45)
sensei = Hero.new("Sensei Ishikawa", 80, 60)

# Villains
m_arch = Archer.new("Mongol Archer", 80, 40, 50)
m_spear = Spearman.new("Mongol Spearman", 120, 60, 50)
m_sword = Swordsman.new("Mongol Swordsman", 100, 50, 50)

game = Game.new(jin)
game.add_hero(yuna)
game.add_hero(sensei)
game.add_villain(m_arch)
game.add_villain(m_spear)
game.add_villain(m_sword)

game.start_game