require './prime.rb' # user defined function
require 'benchmark'

if RUBY_ENGINE =~ /jruby/
  puts 'pre execute for JIT'
  10.times do |i|
    (4..6).each{ |i| prime(10**i) }
  end
end

result = {
  4 => 1229,
  5 => 9592,
  6 => 78498,
  7 => 664579,
  8 => 5761455
}

(7..8).each do |i|
  Benchmark.bm do |x| 
    x.report((10**i).to_s){ raise 'result wrong!' if prime(10**i)!=result[i] }
  end
end
