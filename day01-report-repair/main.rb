test_arr = [1721, 979, 366, 299, 675, 1456]

input_arr = File.open(File.join(File.dirname(__FILE__), 'input.txt')).map { |x| x.to_i }

def expense_report(input, sum, permutations)
  return input.permutation(permutations).to_a.find{|a| a.reduce(:+) == sum}.reduce(:*)
end

puts expense_report(test_arr, 2020, 2)
puts expense_report(input_arr, 2020, 2)

puts expense_report(test_arr, 2020, 3)
puts expense_report(input_arr, 2020, 3)
