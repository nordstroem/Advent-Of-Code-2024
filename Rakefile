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
  raise 'No session cookie found: .session'
end

file test_file do
  raise 'No test input found: inputs/test.txt'
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
    namespace day.to_s do
      (1..2).each do |part|
        task part => f do
          puts solve(day, part, File.read(f))
        end
      end
    end
  end
end

namespace 'test' do
  input_files.each_key do |day|
    namespace day.to_s do
      (1..2).each do |part|
        task part => test_file do
          puts solve(day, part, File.read(test_file))
        end
      end
    end
  end
end
