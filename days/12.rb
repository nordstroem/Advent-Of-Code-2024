Pos = Struct.new(:r, :c) do
  def +(other)
    Pos.new(r + other.r, c + other.c)
  end

  def -(other)
    Pos.new(r - other.r, c - other.c)
  end
end

class Day12
  def valid(grid, p)
    p.r >= 0 && p.c >= 0 && p.r < grid.size && p.c < grid[p.r].size
  end

  def flood_fill(grid, pos)
    type = grid[pos.r][pos.c]
    region = Set.new

    q = [pos]
    until q.empty?
      n = q.pop
      next unless valid(grid, n) && grid[n.r][n.c] == type && !region.include?(n)

      region << n
      q << n + Pos.new(1, 0)
      q << n + Pos.new(-1, 0)
      q << n + Pos.new(0, 1)
      q << n + Pos.new(0, -1)
    end
    region
  end

  def fence_cost(grid, region)
    return 0 if region.empty?

    dp = region.to_a[0]
    type = grid[dp.r][dp.c]

    area = region.size
    perimeter = 0
    deltas = [Pos.new(0, 1), Pos.new(0, -1), Pos.new(1, 0), Pos.new(-1, 0)]
    region.each do |p|
      deltas.each do |delta|
        np = p + delta
        perimeter += 1 if !valid(grid, np) || grid[np.r][np.c] != type
      end
    end
    area * perimeter
  end

  def in_any_region(regions, p)
    regions.any? { |region| region.include?(p) }
  end

  def part1(input)
    grid = input.lines.map { |l| l.strip.chars }.freeze

    regions = []

    sum = 0
    grid.each_with_index do |row, r|
      row.each_with_index do |_, c|
        pos = Pos.new(r, c)
        next if in_any_region(regions, pos)

        region = flood_fill(grid, pos)
        regions << region
        sum += fence_cost(grid, region)
      end
    end
    sum
  end

  def not_of_type(grid, tp, type)
    !valid(grid, tp) || grid[tp.r][tp.c] != type
  end

  def is_up_start(grid, p, type)
    # False if it is not even the correc type
    return false if not_of_type(grid, p, type)
    # False if the up is not of another type
    return false unless not_of_type(grid, p + Pos.new(-1, 0), type)

    # False if any of the ones left is a down start
    tp = p + Pos.new(0, -1)
    until not_of_type(grid, tp, type)
      return false if is_up_start(grid, tp, type)
      break unless not_of_type(grid, tp + Pos.new(-1, 0), type)


      tp += Pos.new(0, -1)
    end
    true
  end

  def is_down_start(grid, p, type)
    # False if it is not even the correc type
    return false if not_of_type(grid, p, type)
    # False if the down is not of another type
    return false unless not_of_type(grid, p + Pos.new(1, 0), type)

    # False if any of the ones left is a down start
    tp = p + Pos.new(0, -1)
    until not_of_type(grid, tp, type)
      return false if is_down_start(grid, tp, type)
      break unless not_of_type(grid, tp + Pos.new(1, 0), type)

      tp += Pos.new(0, -1)
    end
    true
  end

  def is_left_start(grid, p, type)
    # False if it is not even the correc type
    return false if not_of_type(grid, p, type)
    # False if the left  is not of another type
    return false unless not_of_type(grid, p + Pos.new(0, -1), type)

    # False if any of the ones above is a left start
    tp = p + Pos.new(-1, 0)
    until not_of_type(grid, tp, type)
      return false if is_left_start(grid, tp, type)
      break unless not_of_type(grid, tp + Pos.new(0, -1), type)

      tp += Pos.new(-1, 0)
    end
    true
  end

  def is_right_start(grid, p, type)
    # False if it is not even the correct type
    return false if not_of_type(grid, p, type)
    # False if the right is not of another type
    return false unless not_of_type(grid, p + Pos.new(0, 1), type)

    # False if any of the ones above is a right start
    tp = p + Pos.new(-1, 0)
    until not_of_type(grid, tp, type)
      return false if is_right_start(grid, tp, type)
      break unless not_of_type(grid, tp + Pos.new(0, 1), type)

      tp += Pos.new(-1, 0)
    end
    true
  end

  def fence_cost_2(grid, region)
    return 0 if region.empty?

    dp = region.to_a[0]
    type = grid[dp.r][dp.c]

    area = region.size
    perimeter = 0
    region.each do |p|
      perimeter += 1 if is_left_start(grid, p, type)
      perimeter += 1 if is_right_start(grid, p, type)
      perimeter += 1 if is_up_start(grid, p, type)
      perimeter += 1 if is_down_start(grid, p, type)
    end
    area * perimeter
  end

  def part2(input)
    grid = input.lines.map { |l| l.strip.chars }.freeze

    regions = []

    sum = 0
    grid.each_with_index do |row, r|
      row.each_with_index do |_, c|
        pos = Pos.new(r, c)
        next if in_any_region(regions, pos)

        region = flood_fill(grid, pos)
        regions << region
        sum += fence_cost_2(grid, region)
      end
    end
    sum
  end
end
