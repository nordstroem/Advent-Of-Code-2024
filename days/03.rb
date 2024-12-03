class Day03
  def part1(input)
    input.scan(/mul\((\d+),(\d+)\)/).sum { |a, b| a.to_i * b.to_i }
  end

  def part2(input)
    ans = 0
    enabled = true
    pattern = /(do\(\))|(don't\(\))|mul\((\d+),(\d+)\)/
    input.scan(pattern) do |enable, _, a, b|
      if a && b
        ans += a.to_i * b.to_i if enabled
      elsif enable
        enabled = true
      else
        enabled = false
      end
    end
    ans
  end
end
