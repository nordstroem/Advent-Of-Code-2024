class Day11
  def iterate(nums)
    nums.map do |n|
      if n.zero?
        1
      elsif n.to_s.size.even?
        s = n.to_s
        [s[0...(s.size / 2)].to_i, s[(s.size / 2)...].to_i]
      else
        n * 2024
      end
    end.flatten
  end

  def part1(input)
    nums = input.strip.split.map(&:to_i)
    75.times do
      nums = iterate(nums)
    end
    nums.size
  end

  def iterate_2(nums)
    new_nums = nums.dup
    nums.each do |n, count|
      new_nums[n] -= count
      new_nums.delete(n) if new_nums[n] <= 0
      if n.zero?
        new_nums[1] += count
      elsif n.to_s.size.even?
        s = n.to_s
        a = s[0...(s.size / 2)].to_i
        b = s[(s.size / 2)...].to_i
        new_nums[a] += count
        new_nums[b] += count
      else
        new_nums[n * 2024] += count
      end
    end
    new_nums
  end

  def part2(input)
    nums = Hash.new(0).merge! input.strip.split.map(&:to_i).tally
    75.times do
      nums = iterate_2(nums)
    end
    nums.values.sum
  end
end
