WIDTH = 101
HEIGHT = 103

class Day14
  Robot = Struct.new(:x, :y, :vx, :vy) do
    def step
      self.x = (x + vx) % WIDTH
      self.y = (y + vy) % HEIGHT
    end
  end

  def safety_score(robots)
    top_left = 0
    top_right = 0
    bottom_left = 0
    bottom_right = 0
    robots.each do |robot|
      top_left += 1 if robot.x < WIDTH / 2 && robot.y < HEIGHT / 2
      top_right += 1 if robot.x > WIDTH / 2 && robot.y < HEIGHT / 2
      bottom_left += 1 if robot.x < WIDTH / 2 && robot.y > HEIGHT / 2
      bottom_right += 1 if robot.x > WIDTH / 2 && robot.y > HEIGHT / 2
    end
    top_left * top_right * bottom_left * bottom_right
  end

  def print(robots)
    array = Array.new(HEIGHT) { Array.new(WIDTH, '.') }

    robots.each do |robot|
      array[robot.y][robot.x] = '#'
    end

    array.each do |row|
      puts row.join(' ')
    end
  end

  def all_unique?(robots)
    positions = Set.new(robots.map { |robot| [robot.x, robot.y] })
    positions.size == robots.size
  end

  def part1(input)
    robots = input.lines.map do |section|
      Robot.new(*section.scan(/-?\d+/).map(&:to_i))
    end
    100.times do
      robots.each(&:step)
    end
    safety_score(robots)
  end

  def part2(input)
    robots = input.lines.map do |section|
      Robot.new(*section.scan(/-?\d+/).map(&:to_i))
    end
    ans = 0
    loop do
      robots.each(&:step)
      ans += 1
      next unless all_unique?(robots)

      break
    end
    ans
  end
end
