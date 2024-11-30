require 'pathname'
require 'net/http'

def input_files
  (1..25).to_h { |i| [i, Pathname.new("./inputs/#{i.to_s.rjust(2, '0')}.txt")] }
end

def session_file
  '.session'
end

def test_file
  'inputs/test.txt'
end

file session_file do
  raise 'No session cookie found: .session' unless File.exist?('.session')
end

file test_file do
  raise 'No test input found: inputs/test.txt' unless File.exist?('inputs/test.txt')
end

input_files.each do |day, f|
  file f => session_file do
    response = Net::HTTP.get_response(URI("https://adventofcode.com/2024/day/#{day}/input"),
                                      { 'Cookie' => "session=#{File.read(session_file)}" })
    raise "Download failed: #{response.message}" unless response.code == '200'

    mkdir_p f.dirname
    File.write(f, response.body)
  end
end

def solve(day, part, input)
  day_string = day.to_s.rjust(2, '0')
  load "days/#{day_string}.rb"
  solver = Object.const_get("Day#{day_string}").new
  solver.send("part#{part}", input)
end

namespace 'solve' do
  input_files.each do |day, f|
    (1..2).each do |part|
      task "#{day}_#{part}" => f do
        result = solve(day, part, File.read(f))
        puts "Day #{day}, part #{part} result: #{result}"
      end
    end
  end
end

namespace 'test' do
  input_files.each_key do |day|
    (1..2).each do |part|
      task "#{day}_#{part}" => test_file do
        result = solve(day, part, File.read('inputs/test.txt'))
        puts "Day #{day}, part #{part} result: #{result}"
      end
    end
  end
end
