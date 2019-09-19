# Multiple return values
def triple_and_array(s)
    {s * 3, s.split(',')}
end

ret = triple_and_array("4,2")
p ret
p ret[0]
p ret[1]

num, arr = triple_and_array("num,arr")
p num
p arr

def salaries(*employees) : Nil
    employees.each do |emp|
        # calc salary
        p "#{emp}'s salary is: money"
    end
    nil
end

salaries()
salaries("jon", "jason", "bob")

# Not sure I'm understanding how this splat works.
# Why would I use this?
def display(n, *, height, width)
    "height: #{height}, width: #{width}"
end

p display(3, height: 4, width: 9)

def join(*args, with joiner)
    String.build do |str|
        args.each_with_index do |arg, idx|
            # adds the joiner first, and then the arg
            str << joiner if idx > 0
            str << arg
            p idx
        end
    end
end

p join('b', 'c', with: '-')
