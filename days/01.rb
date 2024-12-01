class Day01
  def split(input)
    numbers = input.split.map(&:to_i)
    numbers.partition.with_index { |_, i| i.even? }
  end

  def part1(input)
    left, right = split input
    left.sort.zip(right.sort).map { |l, r| (l - r).abs }.sum
  end

  def part2(input)
    left, right = split input
    occ = right.tally
    left.map { |l| l * occ.fetch(l, 0) }.sum
  end
end
