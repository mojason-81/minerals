var1 = gets
puts typeof(var1)
if var1.responds_to?(:to_i) && var1.to_i?
    var1 = var1.to_i
    if var1 = 1
        puts "inside if"
        var1 = 2
        puts var1
    end
    puts var1
end

if (num = 9) < 0
    puts "#{num}, is negative"
elsif num < 10
    puts "#{num}, has 1 digit"
else
    puts "#{num}, has multiple digits"
end
