require 'benchmark/ips'
require_relative 'lib/crypto'

Benchmark.ips do |x|
  crypto = Crypto.new (1..9).to_a.shuffle.join
  str = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
  str_encoded = crypto.encode str

  x.report('#decode:') { crypto.decode str_encoded }
  x.report('#decode_ex:') { crypto.decode_ex str_encoded }

  x.compare!
end
