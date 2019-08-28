"gold;topaz;apatite;wolframite;calcite;diamond".split(';').map { |s| s.upcase }.each do |m|
    puts m
end
puts "\n\n"
academic_str = "hi 猫"
academic_str.chars.each do |c|
    puts c
    s = c.to_s
    s.codepoints.each do |cp|
        puts cp
    end
    s.bytes.each do |b|
        puts b
    end
    puts "\n\n"
end

CONSTANT_VALUE1 = "blah"
CONSTANT_VALUE2 = "blah"

CONST_INT1 = 1
CONST_INT2 = 1

CONST_BOOL1 = true
CONST_BOOL2 = true

val1_objid = CONSTANT_VALUE1.object_id
val2_objid = CONSTANT_VALUE2.object_id

# Evidently you can't get an object_id from an int or bool
# int1_objid = CONST_INT1.object_id
# int2_objid = CONST_INT1.object_id

# bool1_objid = CONST_BOOL1.object_id
# bool2_objid = CONST_BOOL2.object_id

puts val1_objid === val2_objid
puts CONSTANT_VALUE1.same?(CONSTANT_VALUE2)
# puts int1_objid === int2_objid
# puts bool1_objid === bool2_objid
