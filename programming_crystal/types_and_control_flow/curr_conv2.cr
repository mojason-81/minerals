CURRENCIES = {
    "EUR" => "Euro",
    "CAD" => "Canadian Dollar",
    "CNY" => "Chinese Yuan"
}

puts "Enter the base currency, default is: USD"
base : String | Nil = gets

# If we are exiting without input, why tell the user there's a default?
# exit unless base
if !base || base.strip == ""
    # Default to "USD"
    base = "USD"
end

puts "Enter the other currencies and their exchange rate,"
puts "like this: EUR - 0.843230536"
puts "Stop input by entering 'stop'"
rates = {} of String => Float64
while input = gets
    break unless input
    input.strip
    if input == "" || input == "stop"
        puts "No more input: ok, we stop"
        break
    end
    if !input.includes?(" - ")
        puts("Wrong input format, use: CUR - 1.23456")
        break
    end
    arr = input.split(" - ")
    curr = arr[0].upcase
    if curr.size != 3
        puts "Currency code must be 3 characters"
        break
    end
    rate = arr[1]
    if rate.to_f?
        rates[curr] = rate.to_f
    else
        puts "rate needs to be a decimal number"
    end
end
puts "base: #{base}"
puts "rates: #{rates}"
