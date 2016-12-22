require_relative 'lib/crypto'

c = Crypto.new (1..9).to_a.shuffle.join

File.open('tmp/crypto.encoded', 'w') do |target|
  File.open('crypto/lib/crypto.rb', 'r').each do |src|
    target.puts c.encode(src.chomp)
  end
end

File.open('tmp/crypto.decoded.rb', 'w') do |target|
  File.open('crypto.encoded', 'r').each do |src|
    target.puts c.decode(src.chomp)
  end
end
