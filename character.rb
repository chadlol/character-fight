############################################################
#
# Name:       Chad Ohl
# Assignment: Character Fight - Character Class
# Date:       5/20/14
# Class:      CIS 283
#
############################################################

class Character
  include Enumerable
  attr_reader(:name,:race,:hit_points,:current_hit_points,:strength,:agility,:weapon,:armor)
  def initialize(name,race,hit_points,strength,agility,weapon,armor)
    @name = name
    @race = race
    @hit_points = hit_points.to_i
    @current_hit_points = hit_points.to_i
    @strength = strength.to_i
    @agility = agility.to_i
    @weapon = weapon
    @armor = armor
  end

  def to_s
    return "\nName: #{@name}\n"\
           "Race: #{@race}\n"\
           "Hitpoints: #{@hit_points}\n"\
           "Strength: #{@strength}\n"\
           "Agility: #{@agility}\n"\
           "Weapon: #{@weapon}\n"\
           "Armor: #{@armor}"
  end

  def current_status
    return "#{@name} has #{@current_hit_points}hp/#{@hit_points}hp"
  end

  def reduce_hits(damage)
    @current_hit_points -= damage

    if @current_hit_points <= 0
      return "#{self} is dead."
    else
      return @current_hit_points
    end
  end

  def revive_character
    @current_hit_points = @hit_points
  end

  def <=>(other)
    return self <=> other
  end

end