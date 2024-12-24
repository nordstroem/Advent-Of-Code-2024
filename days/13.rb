class Day13
  Rule = Struct.new(:ax, :ay, :bx, :by, :x, :y)

  def part1(input)
    rules = input.split("\n\n").map do |section|
      Rule.new(*section.scan(/\d+/).map(&:to_i))
    end

    rules.sum do |rule|
      is_set = false
      best_cost = 100 * 3 + 100
      100.times do |ai|
        100.times do |bi|
          x = ai * rule.ax + bi * rule.bx
          y = ai * rule.ay + bi * rule.by

          cost = 3 * ai + bi
          if x == rule.x && y == rule.y && cost < best_cost
            best_cost = cost
            is_set = true
          end
        end
      end
      is_set ? best_cost : 0
    end
  end

  def part2(input)
  end
end
