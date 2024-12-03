class Day02
  def split(input)
    input.lines.map { |line| line.split.map(&:to_i) }
  end

  def difference(lines)
    lines.each_cons(2).map { |a, b| b - a }
  end

  def safe?(diff)
    diff.all? { |num| num.abs.between?(1, 3) } && (diff.all?(&:positive?) || diff.all?(&:negative?))
  end

  def part1(input)
    split(input).map(&method(:difference)).map(&method(:safe?)).count(true)
  end

  def safe_2?(numbers)
    return true if safe? difference(numbers)

    numbers.each_index.any? do |i|
      n = numbers.dup
      n.delete_at(i)
      safe? difference(n)
    end
  end

  def part2(input)
    split(input).map(&method(:safe_2?)).count(true)
  end
end
