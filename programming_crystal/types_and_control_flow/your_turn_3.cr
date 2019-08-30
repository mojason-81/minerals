x = "mystring"
y = {
    :x => "mystring"
}

puts x.object_id
puts y[:x].object_id
puts x.same?(y[:x])

y[:x] = "blah"
puts y[:x].object_id
puts y[:x]
puts x
