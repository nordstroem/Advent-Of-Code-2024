class Day04
  def check_1(row, col, grid)
    rows = grid.size
    cols = grid[0].size

    validate = ->(r, c) { r >= 0 && c >= 0 && r < rows && c < cols }
    check_help = lambda do |r, c, dr, dc|
      return false unless validate.call(r, c) && grid[r][c] == 'X'
      return false unless validate.call(r + dr, c + dc) && grid[r + dr][c + dc] == 'M'
      return false unless validate.call(r + 2 * dr, c + 2 * dc) && grid[r + 2 * dr][c + 2 * dc] == 'A'
      return false unless validate.call(r + 3 * dr, c + 3 * dc) && grid[r + 3 * dr][c + 3 * dc] == 'S'

      true
    end
    count = 0
    count += 1 if check_help.call(row, col, 0, 1)
    count += 1 if check_help.call(row, col, 0, -1)
    count += 1 if check_help.call(row, col, 1, 0)
    count += 1 if check_help.call(row, col, -1, 0)
    count += 1 if check_help.call(row, col, 1, 1)
    count += 1 if check_help.call(row, col, -1, 1)
    count += 1 if check_help.call(row, col, -1, -1)
    count += 1 if check_help.call(row, col, 1, -1)
    count
  end

  def part1(input)
    grid = input.lines.map(&:chars)
    rows = grid.size
    cols = grid[0].size
    ans = 0
    (0..rows).each do |r|
      (0..cols).each do |c|
        ans += check_1(r, c, grid)
      end
    end
    ans
  end

  def check_2(row, col, grid)
    rows = grid.size
    cols = grid[0].size

    validate = ->(r, c) { r >= 0 && c >= 0 && r < rows && c < cols }
    check_help = lambda do |r, c, dr, dc|
      return false unless validate.call(r - dr, c - dc) && grid[r - dr][c - dc] == 'M'
      return false unless validate.call(r, c) && grid[r][c] == 'A'
      return false unless validate.call(r + dr, c + dc) && grid[r + dr][c + dc] == 'S'

      true
    end
    top_right = check_help.call(row, col, 1, 1)
    top_left = check_help.call(row, col, 1, -1)
    bot_right = check_help.call(row, col, -1, 1)
    bot_left = check_help.call(row, col, -1, -1)

    return 1 if top_right && top_left
    return 1 if top_right && bot_right
    return 1 if bot_right && bot_left
    return 1 if bot_left && top_left

    0
  end

  def part2(input)
    grid = input.lines.map(&:chars)
    rows = grid.size
    cols = grid[0].size
    ans = 0
    (0..rows).each do |r|
      (0..cols).each do |c|
        ans += check_2(r, c, grid)
      end
    end
    ans
  end
end
