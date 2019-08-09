puts "Enter the numbers one by one, and end with an empty line:"
arr = [] of Int8

while number = gets
    number = number.strip
    if number == "" || number == "stop"
        break
    end
    begin
        number.to_i8
    rescue ex
       puts "input must be a number not larger than 255" 
       puts ex
    else
        arr << number.to_i8
    ensure
        puts "this always happens"
    end

end
p arr
