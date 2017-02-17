############################################################
#
# Name:       Chad Ohl
# Assignment: Character Fight - Main
# Date:       5/20/14
# Class:      CIS 283
#
############################################################

require_relative("dice.rb")
require_relative("armor.rb")
require_relative("weapon.rb")
require_relative("character.rb")

def menu(chr_1, chr_2)
  return "\n1) Load Character 1#{
  if chr_1 != nil then
    ": #{chr_1.name}"
  end}\n"\
         "2) Load Character 2#{
  if chr_2 != nil then
    ": #{chr_2.name}"
  end}\n"\
         "3) Fight\n"\
         "4) Quit"
end

def character_check(file)

  if file !~ /\.txt\Z/
    file += '.txt'
  end

  if File.exist?(file)
    character = load_character(file)
    return character
  else
    character = nil
    return character
  end
end

def load_character(character_file)

  character_file = File.new(character_file, "r") #Open File

  character_info = []

  character_file.each { |line|
    character_info << line.chomp.split(",")
  }

  character_file.close #Close File

  return Character.new(character_info[0][0], character_info[0][1],
                       character_info[0][2], character_info[0][3],
                       character_info[0][4],
                       Weapon.new(character_info[1][0], character_info[1][1]),
                       Armor.new(character_info[2][0], character_info[2][1]))

end

def fight(winner, looser)

  if $die_10.roll < winner.agility

    hit = (winner.strength * (1.0/$die_4.roll) + (winner.weapon.hits)/$die_8.roll).to_i
    armor_save = (looser.armor.hits/$die_15.roll).to_i
    damage = hit - armor_save
    if damage < 0
      damage = 0
    end

    looser.reduce_hits(damage)

    return "#{winner.name} fights with the #{winner.weapon.name}\n"\
      "\tHit: #{hit}\t\t#{looser.name}\'s armor saved #{armor_save} points\n"\
      "#{looser.name}\'s hits are reduced by #{damage} points.\n#{looser.current_status}\n"\

  else
    return "#{winner.name} fights with the #{winner.weapon.name}\n"\
      "\tMisses!"
  end
end

user_choice = 0
character_1 = nil
character_2 = nil

while user_choice != 4
  puts menu(character_1, character_2)
  print 'Enter a selection: '
  user_choice = gets.to_i

  if user_choice == 1

    print 'Enter name of character 1 file(e.g., dude.txt): '
    character_file = gets.chomp

    character_1 = character_check(character_file)

    puts character_1 != nil ? "#{character_1}\nCharacter Loaded!\n" : "File does not exist!"

    print "\nPress enter to return to menu..."
    gets

  elsif user_choice == 2

    print 'Enter name of character 1 file(e.g., dude.txt): '
    character_file = gets.chomp

    character_2 = character_check(character_file)

    puts character_2 != nil ? "#{character_2}\nCharacter Loaded!\n" : "File does not exist!"

    print "\nPress enter to return to menu..."
    gets

  elsif user_choice == 3

    if character_1 == nil || character_2 == nil
      puts "\nBoth characters must be loaded before beginning a fight!"
      print "Press enter to return to menu..."
      gets

    else
      while character_1.current_hit_points > 0 && character_2.current_hit_points > 0
        agility_die_1 = Dice.new(character_1.agility).roll
        agility_die_2 = Dice.new(character_2.agility).roll

        if agility_die_1 > agility_die_2
          puts
          puts fight(character_1, character_2)
          if character_2.current_hit_points > 0
            puts fight(character_2, character_1)
          end
        elsif agility_die_2 > agility_die_1
          puts
          puts fight(character_2, character_1)
          if character_1.current_hit_points > 0
            puts fight(character_1, character_2)
          end
        elsif agility_die_1 == agility_die_2
          puts "Tie!"
        end

        if character_1.current_hit_points > 0 && character_2.current_hit_points > 0
          print "Press enter to fight again..."
          gets
        end
      end

      if character_1.current_hit_points > character_2.current_hit_points
        puts "\n#{character_1.name} WINS!"
      elsif character_2.current_hit_points > character_1.current_hit_points
        puts "\n#{character_2.name} WINS!"
      end

      30.times do print "-" end
      puts
      puts character_1.current_status
      puts character_2.current_status
      30.times do print "-" end
      puts

      character_1.revive_character
      character_2.revive_character
    end
  end
end