require_relative 'lib/linked-list'
require_relative 'lib/node'

link_test = LinkedList.new()

puts "Size: #{link_test.size} Head: #{link_test.head&.value} Tail: #{link_test.tail&.value}"

puts "Append 1: #{link_test.append("Kevin")}"
puts "Append 2: #{link_test.append("Ivy")}"
puts "Append 3: #{link_test.append("Mary Jo")}"
puts "Append 4: #{link_test.append("Lauren")}"
puts "Append 5: #{link_test.append("Jeanette")}"
puts "Size: #{link_test.size} Head: #{link_test.head&.value} Tail: #{link_test.tail&.value}"
puts "At 1: #{link_test.at(1).value}"
puts "to_s: #{link_test.to_s}"

puts "Prepend 1: #{link_test.prepend("Everly")}"
puts "Prepend 2: #{link_test.prepend("Craig")}"
puts "Prepend 3: #{link_test.prepend("Scott")}"
puts "Size: #{link_test.size} Head: #{link_test.head&.value} Tail: #{link_test.tail&.value}"
puts "At 1: #{link_test.at(1).value}"
puts "to_s: #{link_test.to_s}"

puts "Pop 1: #{link_test.pop.value}"
puts "to_s: #{link_test.to_s}"

puts "Find Ivy? #{link_test.find("Ivy")}"
puts "Find Jeanette? #{link_test.find("Jeanette")}"
puts "Contains Kevin? #{link_test.contains?("Kevin")}"
puts "Contains Jeanette? #{link_test.contains?("Jeanette")}"

puts "Insert Jeanette at 5: #{link_test.insert_at(5, "Jeanette")}"
puts "to_s: #{link_test.to_s}"

puts "Remove At 6: #{link_test.remove_at(6)}"
puts "to_s: #{link_test.to_s}"