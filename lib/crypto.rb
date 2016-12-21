class Crypto
  def initialize(key)
    @key = validate key
  end

  def encode(str)
    perform str do |sequence|
      @key.map { |i| sequence[i - 1] }
    end
  end

  def decode(str)
    perform str do |sequence|
      normalize_encoded! sequence

      tmp = Array.new @key.size
      @key.each_with_index { |k, i| tmp[k - 1] = sequence[i] }
      tmp
    end
  end

  private

  # TODO: Extract to "Validator" module/class
  def validate(key)
    key = key.to_s
    key = key.chars.map(&:to_i)

    error = 'Key values must be of 123456789' if key.sort != (1..key.size).to_a
    error = 'Key values must be unique' if key.uniq.length != key.length
    error = 'Key length must be between 2 and 9' if key.size < 2 || key.size > 9
    raise ArgumentError, error if error

    return key
  end

  def perform(str)
    str.chars
      .each_slice(@key.size)
      .map { |sequence| yield sequence }
      .join
  end

  # Fill sequence with nil when key value is greater than sequence length
  def normalize_encoded!(sequence)
    return if @key.size == sequence.size

    encoded_size = sequence.size
    @key.each_with_index do |k, i|
      sequence.insert(i, nil) if k > encoded_size
    end
  end
end
