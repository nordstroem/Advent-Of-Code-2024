class Day13
  Rule = Struct.new(:ax, :ay, :bx, :by, :x, :y)

  def get_cost(rule)
    det = rule.ax * rule.by - rule.ay * rule.bx
    return 0 if det.zero?

    sa = (rule.by * rule.x - rule.bx * rule.y) / det
    sb = (-rule.ay * rule.x + rule.ax * rule.y) / det

    return 0 if sa < 0 || sb < 0

    return 0 if (sa * rule.ax + sb * rule.bx) != rule.x
    return 0 if (sa * rule.ay + sb * rule.by) != rule.y

    (3 * sa + sb)
  end

  def part1(input)
    rules = input.split("\n\n").map do |section|
      Rule.new(*section.scan(/\d+/).map(&:to_i))
    end

    rules.sum do |rule|
      get_cost(rule)
    end
  end

  def part2(input)
    rules = input.split("\n\n").map do |section|
      Rule.new(*section.scan(/\d+/).map(&:to_i))
    end

    rules.sum do |rule|
      rule.x += 10_000_000_000_000
      rule.y += 10_000_000_000_000
      get_cost(rule)
    end
  end
end
