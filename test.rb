key = [2, 3, 1]
s = %w(d l)
a = key.each_with_index do |k, i|
  s.insert(i, nil) if k > s.size
end
p s
p a
