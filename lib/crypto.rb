class Crypto
  def initialize(key)
    key = key.to_str
    @key = key.split('').map(&:to_i)
  end

  def encode(str)
    result = []
    str.split('').each_slice(@key.size) do |sentence|
      result << @key.map do |i|
        sentence[i - 1]
      end
    end
    result.flatten.compact.join
  end

  def decode(str)
    result = []
    str.split('').each_slice(@key.size) do |sentence|
      tmp = []
      @key.each_with_index do |k, i|
        tmp[k - 1] = sentence[i]
      end
      result << tmp
    end
    result.flatten.compact.join
  end
end
