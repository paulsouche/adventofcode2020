test = '0,3,6'
test_2 = '1,3,2'
test_3 = '2,1,3'
test_4 = '1,2,3'
test_5 = '2,3,1'
test_6 = '3,2,1'
test_7 = '3,1,2'

input = '0,13,16,17,1,10,6'

class Game
  def initialize(input)
    numbers = input.split(',').map {|x| x.to_i}
    @round = 1
    @map = {}
    @last = numbers.last

    for i in 0..numbers.length - 2
      @map[numbers[i]] = [i + 1]
      @round += 1
    end
  end

  def last
    @last
  end

  def play_round
    if !@map.dig(@last)
      @map[@last] = [@round]
      @last = 0
    else
      @last = @map[@last].last - @map[@last].first
    end

    @round +=1

    if @map.dig(@last)
      @map[@last].shift() if @map[@last].length >= 2
      @map[@last].push(@round)
    end
  end

  def run(round)
    while @round < round
      play_round()
    end
    self
  end
end

def play(test, round)
  Game.new(test).run(round).last
end

puts play(test, 2020)
puts play(test_2, 2020)
puts play(test_3, 2020)
puts play(test_4, 2020)
puts play(test_5, 2020)
puts play(test_6, 2020)
puts play(test_7, 2020)
puts play(input, 2020)

puts play(input, 30000000)