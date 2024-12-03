class Day03
  def part1(input)
    input.scan(/mul\((\d+),(\d+)\)/).sum { |a, b| a.to_i * b.to_i }
  end

  def part2(input)
    start = 0
    ans = 0
    should_add = true
    while start < input.length
      do_index = input.index(/do\(\)/, start) || input.length
      dont_index = input.index(/don't\(\)/, start) || input.length
      mul_index = input.index(/mul\(\d+,\d+\)/, start) || input.length

      if mul_index < do_index && mul_index < dont_index
        ans += input[start...input.length].scan(/mul\((\d+),(\d+)\)/).map { |a, b| a.to_i * b.to_i }[0] if should_add
      elsif do_index < dont_index
        should_add = true
      else
        should_add = false
      end
      start = [mul_index, dont_index, do_index].min + 1
    end
    ans
  end
end
