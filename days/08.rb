class Day08
  def get_antenna_map(grid)
    grid.each_with_index.with_object(Hash.new { |h, k| h[k] = [] }) do |(row, r), antennas|
      row.each_with_index do |v, c|
        antennas[v] << [r, c] if v != '.'
      end
    end
  end

  def valid?(grid, r, c)
    r >= 0 && c >= 0 && r < grid.size && c < grid[r].size
  end

  def get_antinodes(grid, antennas)
    antinodes = Set.new
    antennas.combination(2).each do |(r1, c1), (r2, c2)|
      dr = r1 - r2
      dc = c1 - c2
      node1 = [r1 + dr, c1 + dc]
      node2 = [r2 - dr, c2 - dc]
      antinodes << node1 if valid?(grid, *node1)
      antinodes << node2 if valid?(grid, *node2)
    end
    antinodes
  end

  def part1(input)
    grid = input.lines.map { |l| l.strip.chars }.freeze
    antenna_map = get_antenna_map(grid)
    antinodes = Set.new
    antenna_map.each_value do |antennas|
      antinodes += get_antinodes(grid, antennas)
    end
    antinodes.size
  end

  def get_antinodes_p2(grid, antennas)
    antinodes = Set.new
    antennas.combination(2).each do |(r1, c1), (r2, c2)|
      dr = r1 - r2
      dc = c1 - c2
      node1 = [r1, c1]
      node2 = [r2, c2]
      i = 0
      while valid?(grid, *node1) || valid?(grid, *node2)
        node1 = [r1 + i * dr, c1 + i * dc]
        node2 = [r2 - i * dr, c2 - i * dc]
        antinodes << node1 if valid?(grid, *node1)
        antinodes << node2 if valid?(grid, *node2)
        i += 1
      end
    end
    antinodes
  end

  def part2(input)
    grid = input.lines.map { |l| l.strip.chars }.freeze
    antenna_map = get_antenna_map(grid)
    antinodes = Set.new
    antenna_map.each_value do |antennas|
      antinodes += get_antinodes_p2(grid, antennas)
    end
    antinodes.size
  end
end
