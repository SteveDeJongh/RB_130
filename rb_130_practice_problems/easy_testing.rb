##### RB 130 - Ruby Foundations: More Topics - Easy Testing #####

=begin

# 1) Boolean Assertions

assert(value.odd?), 'value is not odd'
#or
assert_equal(true, value.odd?)

# 2) Equality Assertions

assert_equal('xyz', value.downcase)

# 3) Nil Assertions

assert_nil(value)

# 4) Empty Objet Assertions

assert_empty(list)

# 5) Included Object Assertions

assert_includes(list, 'xyz')
# assert includes first argument is collection, 2nd is item we are searching for.

# 6) Exception Assertions

assert_raises(NoExperienceError) do
  employee.hire
end

# 7) Type Assertions

assert_instance_of(Numeric, value)

# 8) Kind Assertions

assert_kind_of(Numeric, value)

# 9) Same Object Assertions

assert_same(list, list.process)

# 10) Refutations

refute_includes(list, 'xyz')

=end