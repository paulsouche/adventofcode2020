test_expression = '1 + 2 * 3 + 4 * 5 + 6'

input_arr = File.open(File.join(File.dirname(__FILE__), 'input.txt')).read().split("\n")

PARENTHESES_REGEX = /\([0-9,\s,\+,\*]+\)/

ADDITIONS_REGEX = /([0-9]+\s\+\s[0-9]+)/

def calc_expression_1(expression)
  suite = expression.split(' ')
  num = suite.shift().to_i
  operator = suite.shift()

  while suite.length > 0
    num = operator == '+' ? num + suite.shift().to_i : num * suite.shift().to_i
    operator = suite.shift()
  end
  num
end

puts calc_expression_1(test_expression)

def calc_expression_2(expression)
  capture = ADDITIONS_REGEX.match(expression).to_s
  while capture != ''
    expression.sub! capture, calc_expression_1(capture).to_s
    capture = ADDITIONS_REGEX.match(expression).to_s
  end
  calc_expression_1(expression)
end

puts calc_expression_2(test_expression)

def calc_operation(operation, fn)
  capture = PARENTHESES_REGEX.match(operation).to_s
  while capture != ''
    operation.sub! capture, method(fn).call(capture[1..-2]).to_s
    capture = PARENTHESES_REGEX.match(operation).to_s
  end
  method(fn).call(operation)
end

test_operation_1 = '1 + (2 * 3) + (4 * (5 + 6))'
test_operation_2 = '2 * 3 + (4 * 5)'
test_operation_3 = '5 + (8 * 3 + 9 + 3 * 4 * 3)'
test_operation_4 = '5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))'
test_operation_5 = '((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2'

puts calc_operation(test_operation_1.dup, :calc_expression_1)
puts calc_operation(test_operation_2.dup, :calc_expression_1)
puts calc_operation(test_operation_3.dup, :calc_expression_1)
puts calc_operation(test_operation_4.dup, :calc_expression_1)
puts calc_operation(test_operation_5.dup, :calc_expression_1)

puts calc_operation(test_operation_1.dup, :calc_expression_2)
puts calc_operation(test_operation_2.dup, :calc_expression_2)
puts calc_operation(test_operation_3.dup, :calc_expression_2)
puts calc_operation(test_operation_4.dup, :calc_expression_2)
puts calc_operation(test_operation_5.dup, :calc_expression_2)

def sum_expressions(input, fn)
  input.reduce(0) { |acc, operation| acc += calc_operation(operation.dup, fn) }
end

puts sum_expressions(input_arr, :calc_expression_1)
puts sum_expressions(input_arr, :calc_expression_2)
