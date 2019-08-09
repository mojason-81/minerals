# This is a comment
puts "hello world"

PI = 3.14

a, b = 1, 2

canIVote = true

puts sizeof(Int8)
puts sizeof(Int16)
puts sizeof(Int32)
puts sizeof(UInt64)
puts sizeof(Float32)
puts sizeof(Float64)

puts "#{PI} + #{a} = #{PI + a}"

multString = "I
use
toilet
paper"

puts multString + " concatted!"
puts "Egg".size
puts "MOney" * 3

puts "have a good day".gsub("good") { "shitty" }
puts "have a good day".insert(6, " shit")

array3 = [1, 2, 3] of String | Int32
array4 = Array(Int32).new
names = "paul,sue,jon".split(",")
puts array3.size
puts array3[1]
puts names[1, 2]
puts names[-1]
names << "jason"
puts names.sort
puts names.sort.reverse
puts names.pop
puts names.shift
puts names.includes? "sue"
array4.push(4, 5, 6, 78)
puts array4.map! { |x| x * x }
array5 = [1, 2, 3]
puts array5.permutations

array5.each do |value|
  puts value
end

x = 1
while x <= 10
  x += 1
  next unless (x % 2) == 0
  puts x
end

# print "language : "
# lang = gets
# case lang
# when "French", "french"
#   puts "Bonjour"
#   exit
# when "Spanish", "spanish"
#   puts "Hola"
#   exit
# else
#   puts "Hello"
# end

age = 55

puts (age >= 50) ? "Old" : "Young"

print "Enter 1st value "
n1 = gets.not_nil!
print "Enter 2nd value "
n2 = gets.not_nil!

puts "#{n1} + #{n2} = #{n1.to_i + n2.to_i}"
puts "sqrt(#{n1.to_i + n2.to_i}) = #{Math.sqrt(n1.to_i + n2.to_i)}"
puts "cbrt(#{n1.to_i + n2.to_i}) = #{Math.cbrt(n1.to_i + n2.to_i)}"

nHash = {"PI"     => 3.14,
         "Golden" => 1.618,
         "e"      => 2.718}

puts nHash["PI"]
nHash.each do |key, value|
  puts key.to_s + " : " + value.to_s
end

t1 = {"jason", 38, 250}

puts t1[0]

t1.each do |v|
  puts v
end

puts t1.last
puts t1.size

proc = ->(x : Int32) { x * x }

puts proc.call(5)

def addNums(n1, n2)
  n1 + n2
end

puts addNums(5, 5)

x = 1

def changeX(x)
  x = 5
end

changeX(x)

puts x

def getSum(*vals)
  sum = 0
  vals.each do |val|
    sum += val
  end
  sum
end

puts getSum(1, 2, 3, 4, 5)

enum Color : UInt8
  Blue
  Red
  Green = 4

  def green?
    self == Color::Green
  end
end

puts Color::Green.value
puts Color::Green.green?

:jason
puts :jason

class Animal
  def initialize(name : String)
    puts "Animal created"
    @name = name
  end

  def setName(name)
    @name = name
  end

  def getName
    @name
  end

  def name
    @name
  end

  def name=(name)
    if name.is_a?(Number)
      puts "Name can't be a number"
    else
      @name = name
    end
  end
end

cat = Animal.new("Mittens")
cat.name = 1
cat.name = "Snoball"
puts cat.getName

class Dog
  property name : String
  property height : Float32
  property weight : Float32

  def initialize
    @name = "No Name"
    @height = 0
    @weight = 0
  end

  def bark
    return "bark"
  end
end

rover = Dog.new
rover.name = "Rover"
puts "#{rover.name} says #{rover.bark}"

class GermanSheppard < Dog
  def bark
    return "WOOF"
  end
end

max = GermanSheppard.new
max.name = "Max"
puts "#{max.name} says #{max.bark}"

module Vehicle
  def makeSound
    puts "vroom"
  end
end

class MacTruck
  include Vehicle
end

macTruck = MacTruck.new
macTruck.makeSound

class Bird
  def tweet(bird_type)
    bird_type.tweet
  end
end

class Cardinal < Bird
  def tweet
    puts "tweet tweet"
  end
end

class Parrot < Bird
  def tweet
    puts "squawk"
  end
end

generic_bird = Bird.new
generic_bird.tweet(Cardinal.new)
generic_bird.tweet(Parrot.new)

struct Location
  property lat : Float32
  property long : Float32

  def initialize(@lat : Float32, @long : Float32)
  end

  def position
    puts "Latitude : #{@lat}, Longitude : #{long}"
  end
end

where = Location.new(80.31, 72.62)
where.position

print "Enter a number : "
f_num = gets.not_nil!

print "Enter a number : "
s_num = gets.not_nil!

begin
  answer = f_num.to_i / s_num.to_i
rescue exception
  puts "Yout can't divide by 0"
  exit
end

puts "#{f_num} / #{s_num} = #{answer}"

age = -1
begin
  if (age < 0)
    raise "Enter a positive number"
  end
rescue e
  puts "that's not possible"
end

write_handler = File.new("somefile.out", "w")
write_handler.puts("random text").to_s
write_handler.close
data_from_file = File.read("somefile.out")
puts data_from_file
