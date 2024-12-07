class Day07
  def apply(values, operators)
    ans = values[0]
    operators.zip(values[1..]).each do |op, value|
      ans += value if op == '+'
      ans *= value if op == '*'
      ans = (ans.to_s + value.to_s).to_i if op == '||'
    end
    ans
  end

  def valid?(res, values, operators)
    res == apply(values, operators)
  end

  def solve(input, operators)
    ans = 0
    input.lines.map { |l| l.scan(/\d+/).map(&:to_i) }.each do |row|
      res, *values = row
      n = values.size - 1
      operators.repeated_permutation(n).each do |op|
        if valid?(res, values, op)
          ans += res
          break
        end
      end
    end
    ans
  end

  def part1(input)
    solve(input, ['*', '+'])
  end

  def part2(input)
    solve(input, ['*', '+', '||'])
  end
end
