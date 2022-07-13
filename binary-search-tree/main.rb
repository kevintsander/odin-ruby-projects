require_relative 'lib/tree.rb'

test_arr = Array.new(15) { rand(1..100) }

test_tree = Tree.new(test_arr)

puts "Balanced? #{test_tree.balanced?}"

puts "Preorder: #{test_tree.preorder}"
puts "Postorder: #{test_tree.postorder}"
puts "Inorder: #{test_tree.inorder}"

puts "Insert values to unbalance"
insert_vals = Array.new(5) { rand(101..999) }
insert_vals.each { |value| test_tree.insert(value) }

puts "Balanced? #{test_tree.balanced?}"

puts "Rebalance"
test_tree.rebalance

puts "Balanced? #{test_tree.balanced?}"

puts "Preorder: #{test_tree.preorder}"
puts "Postorder: #{test_tree.postorder}"
puts "Inorder: #{test_tree.inorder}"