def all_days
  Dir['./days/*.rb']
end

namespace 'solve' do
  all_days.each do |file|
    day = file[-5, 2].to_i
    desc "Solve day #{day}"
    task day do
      load file
      if defined? part1
        part1 'dummy'
      end
      if defined? part2
        part2 'dummy'
      end
    end
  end
end
