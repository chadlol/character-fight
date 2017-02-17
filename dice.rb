############################################################
#
# Name:       Chad Ohl
# Assignment: Character Fight - Dice Class
# Date:       5/20/14
# Class:      CIS 283
#
############################################################

class Dice
  def initialize(num_sides)
    @num_sides = num_sides
  end

  def roll
    return rand(1..@num_sides)
  end

  $die_4 = Dice.new(4)
  $die_5 = Dice.new(5)
  $die_8 = Dice.new(8)
  $die_10 = Dice.new(10)
  $die_15 = Dice.new(15)

end