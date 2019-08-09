puts "Number of command line arguments: #{ARGV.size}" # => (1)

ARGV.​each_with_index​ ​do​ |arg, i|
  puts ​"Argument ​​#{​i​}​​: ​​#{​arg​}​​"​ ​# => (2)​
​end​
​ 
p ARGV                                ​# => (3)​
p ​"Executable name: ​​#{​PROGRAM_NAME​}​​"​  ​# => (4)​
p ​"Path to source file: ​​#{​​__FILE__​​}​​"​  ​# => (5)​
p ​"Folder of source file: ​​#{​__DIR__​}​​"​ ​# => (6)
