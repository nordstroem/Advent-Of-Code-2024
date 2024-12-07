require 'set'

class Day06
  def guard_position(grid)
    grid.each_with_index do |row, r|
      c = row.index('^')
      return Complex(c, r) if c
    end
    raise 'Could not find guard'
  end

  def inside?(grid, position)
    r = position.imag
    c = position.real
    r >= 0 && c >= 0 && r < grid.size && c < grid[0].size
  end

  def wall?(grid, position)
    grid[position.imag][position.real] == '#'
  end

  def part1(input)
    grid = input.lines.map(&:chars)
    guard = guard_position grid
    dir = -1i
    visited = Set.new [guard]
    loop do
      new_position = guard + dir
      break unless inside?(grid, new_position)

      if wall?(grid, new_position)
        dir *= 1i
      else
        visited << new_position
        guard = new_position
      end
    end
    visited.size
  end

  def loop?(grid, guard)
    guard = guard.dup
    dir = -1i
    visited = Set.new [[guard, dir]]
    loop do
      new_position = guard + dir
      break unless inside?(grid, new_position)

      if wall?(grid, new_position)
        dir *= 1i
      elsif visited.include? [new_position, dir]
        return true
      else
        visited << [new_position, dir]
        guard = new_position
      end
    end
    false
  end

  def part2(input)
    grid = input.lines.map(&:chars)
    guard = guard_position grid

    ans = 0
    grid.size.times do |r|
      grid[r].size.times do |c|
        next unless grid[r][c] == '.'

        test_grid = grid.map(&:clone)
        test_grid[r][c] = '#'
        ans += 1 if loop?(test_grid, guard)
      end
    end
    ans
  end
end
