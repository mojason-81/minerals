def total(*args, init : Int = 0)
    args.reduce(init) { |acc, i| acc + i }
end

p total(1,2,3,4)
p total(1,2,3,4, init: 8)

tuple_for_splatting = {1,2,3,4}
named_tuple_for_splatting = {one: 1, two: 2, three: 3, four: 4}

def other_total(init : Int = 0, **args)
    p args.keys # interestingly, this is a tuple and not an array
    args.values.reduce(init) { |acc, i| acc + i }
end

def process_named_tuple(one, two, three, four, init : Int = 0)
    [one, two, three, four].reduce(init) { |acc, i| acc + i }
end

p total(*tuple_for_splatting)
p total(*tuple_for_splatting, init: 8)

p other_total(**named_tuple_for_splatting)
p other_total(**named_tuple_for_splatting, init: 8)

p process_named_tuple(**named_tuple_for_splatting)
p process_named_tuple(**named_tuple_for_splatting, init: 8)