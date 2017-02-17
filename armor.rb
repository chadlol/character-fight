############################################################
#
# Name:       Chad Ohl
# Assignment: Character Fight - Armor Class
# Date:       5/20/14
# Class:      CIS 283
#
############################################################

class Armor
  attr_reader(:name, :hits)
  def initialize(name, hits)
    @name = name
    @hits = hits.to_i
  end

  def to_s
    return @name
  end
end