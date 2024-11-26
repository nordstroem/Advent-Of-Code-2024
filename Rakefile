require 'pathname'

def input_files
  (1..25).to_h { |i| [i, Pathname.new("./inputs/#{i.to_s.rjust(2,'0')}.txt")] }
end

input_files.each_value do |f|
  file f do
    mkdir_p f.dirname
    touch f
  end
end

namespace 'solve' do
  input_files.each do |i, f|
    task i => f do
      puts "Solving #{i}"
    end
  end
end
