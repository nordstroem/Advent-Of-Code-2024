class Day05
  def prepare(input)
    rules_str, orders_str = input.split("\n\n")
    rules = Hash.new { |h, k| h[k] = [] }
    rules_str.lines.map { |x| x.strip.split('|') }.each { |l, r| rules[l.to_i].append(r.to_i) }
    orders = orders_str.lines.map { |x| x.strip.split(',').map(&:to_i) }
    [rules, orders]
  end

  def valid?(rules, order)
    order.reverse.each_with_index do |val, i|
      return false if (order[0...order.size - i] & rules[val]).any?
    end
    true
  end

  def part1(input)
    rules, orders = prepare input
    orders.filter { |o| valid?(rules, o) }.sum { |o| o[o.size / 2] }
  end

  def topological_sort(rules, order)
    visited = {}
    stack = []
    dfs = lambda do |node|
      return if visited[node] == :permanent
      raise 'Cycle detected' if visited[node] == :temporary

      visited[node] = :temporary
      (rules[node] & order).each do |neighbor|
        dfs.call(neighbor)
      end
      visited[node] = :permanent
      stack.push(node)
    end

    order.each do |node|
      dfs.call(node) unless visited[node]
    end

    stack.reverse
  end

  def part2(input)
    rules, orders = prepare input
    orders.filter { |o| !valid?(rules, o) }.map { |o| topological_sort(rules, o) }.sum { |o| o[o.size / 2] }
  end
end
