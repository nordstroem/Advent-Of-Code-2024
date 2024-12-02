class Day02
  def split(input)
    input.split("\n").map(&:split).map { |numbers| numbers.map(&:to_i) }
  end

  def difference(lines)
    lines.each_cons(2).map { |a, b| b - a }
  end

  def safe?(diff)
    diff.all? { |num| num.abs >= 1 && num.abs <= 3 } && (diff.all?(&:positive?) || diff.all?(&:negative?))
  end

  def part1(input)
    split(input).map(&method(:difference)).map(&method(:safe?)).count(true)
  end

  def safe_2?(numbers)
    diff = difference(numbers)
    return true if safe? diff

    numbers.each_index do |i|
      n = numbers.dup
      n.delete_at(i)
      diff = difference(n)
      return true if safe?(diff)
    end
    false
  end

  def part2(input)
    split(input).map(&method(:safe_2?)).count(true)
  end
end
