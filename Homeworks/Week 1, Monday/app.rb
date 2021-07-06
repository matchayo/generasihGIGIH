require_relative 'person.rb'

jin = Person.new("Jin Sakai", 100, 50, 0.8)
puts jin

khotun = Person.new("Khotun Khan", 500, 50)
puts khotun

attacker = jin

while jin.alive && khotun.alive
  if attacker == jin
    jin.attack(khotun)
    attacker = khotun

  elsif attacker == khotun
    khotun.attack(jin)
    attacker = jin
  end
end

if jin.alive
  puts "#{khotun.name} dies."
else
  puts "#{jin.name} dies."
end
