require "./modules"

class Mineral
  include Hardness
  property common_name : String
  property crystal_struct : String | Nil
  # getter hardness : Float64

  UNKNOWN = "UNKNOWN"

  def initialize(@common_name, @crystal_struct)
  end

  def describe
    "This is #{common_name} with a Mohs hardness of #{hardness} and a structure of #{crystal_struct || UNKNOWN}."
  end

  def to_s
    "Mineral: common_name => #{common_name}, hardness => #{hardness}, crystal_struct => #{crystal_struct || UNKNOWN}"
  end
end

mines = [Mineral.new("talc", nil), Mineral.new("calcite", nil), Mineral.new("corundum", nil)]
mines.each do |mine|
  puts mine.describe
  puts mine.to_s
  puts
end
