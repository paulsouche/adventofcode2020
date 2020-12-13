require 'ostruct'

test_arr = [
  '939',
  '7,13,x,x,59,x,31,19'
]

test_arr_2 = [
  '',
  '17,x,13,19'
]

test_arr_3 = [
  '',
  '67,7,59,61'
]

test_arr_4 = [
  '',
  '67,x,7,59,61'
]

test_arr_5 = [
  '',
  '67,7,x,59,61'
]

test_arr_6 = [
  '',
  '1789,37,47,1889'
]

input_arr = File.open(File.join(File.dirname(__FILE__), 'input.txt')).read().split("\n")

def parse_input(input)
  start, buses = input.map { |line| line.split(',') }

  OpenStruct.new({
    start: start.first.to_i,
    buses: buses
      .select { |x| x != 'x' }
      .map { |x| OpenStruct.new({
        step: x.to_i,
        index: buses.find_index(x)
      })}
  })
end

def part1(input)
  notes = parse_input(input)
  min = OpenStruct.new({
    start: Float::INFINITY,
    id: nil
  })

  notes.buses.each do |bus|
    timestamp = ((notes.start / bus.step).floor + 1) * bus.step

    if timestamp < min.start
      min.start = timestamp
      min.id = bus.step
    end
  end

  (min.start - notes.start) * min.id
end

def part2(input)
  notes = parse_input(input)
  timestamp = 0
  acc = 1

  notes.buses.each do |bus|
    while (timestamp + bus.index) % bus.step != 0
      timestamp += acc
    end

    acc *= bus.step
  end

  timestamp
end

puts part1(test_arr)
puts part1(input_arr)

puts part2(test_arr)
puts part2(test_arr_2)
puts part2(test_arr_3)
puts part2(test_arr_4)
puts part2(test_arr_5)
puts part2(test_arr_6)
puts part2(input_arr)
