class Day10
  def get_trailheads(grid)
    grid.flat_map.with_index do |row, r|
      row.each_index.select { |c| row[c].zero? }.map { |c| [r, c] }
    end
  end

  def get_neighbours(pos, grid)
    r, c = pos
    is_valid = lambda do |rt, ct|
      return false if rt.negative? || ct.negative? || rt >= grid.size || ct >= grid[rt].size

      (grid[rt][ct] - grid[r][c]) == 1
    end

    nbs = []
    nbs.append([r - 1, c]) if is_valid.call(r - 1, c)
    nbs.append([r + 1, c]) if is_valid.call(r + 1, c)
    nbs.append([r, c + 1]) if is_valid.call(r, c + 1)
    nbs.append([r, c - 1]) if is_valid.call(r, c - 1)
    nbs
  end

  def get_valid_paths(pos, grid, visited)
    r, c = pos
    visited << pos

    return [visited.dup] if grid[r][c] == 9

    valid_paths = []

    get_neighbours(pos, grid).each do |nb|
      next if visited.include?(nb)

      test_paths = get_valid_paths(nb, grid, visited.dup)
      valid_paths += test_paths if test_paths
    end

    valid_paths
  end

  def to_int(char)
    return -1 if char == '.'

    char.to_i
  end

  def part1(input)
    grid = input.lines.map { |line| line.strip.chars.map { |c| to_int(c) } }
    trailheads = get_trailheads(grid)
    trailheads.sum do |p|
      x = Set.new
      paths = get_valid_paths(p, grid, [])
      x += (paths.map { |ps| ps[-1] })
      x.size
    end
  end

  def part2(input)
    grid = input.lines.map { |line| line.strip.chars.map { |c| to_int(c) } }
    trailheads = get_trailheads(grid)
    trailheads.sum do |p|
      get_valid_paths(p, grid, []).size
    end
  end
end
