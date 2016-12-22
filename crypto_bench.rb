require 'benchmark'
require_relative 'lib/crypto'

i = 100_000
c = Crypto.new (1..9).to_a.shuffle.join
str = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'.freeze
str_encoded = c.encode str

# check if string correctly decoded
puts c.decode str_encoded
puts

Benchmark.bm do |x|
  x.report('Encode:') do
    i.times { c.encode str }
  end

  x.report('Decode:') do
    i.times { c.decode str_encoded }
  end
end
