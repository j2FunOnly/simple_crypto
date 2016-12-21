class Crypto
  def initialize(key)
    @key = validate key
  end

  def encode(str)
    perform str do |sequence|
      @key.map do |i|
        sequence[i - 1]
      end
    end
  end

  def decode(str)
    perform str do |sequence|
      sequence = normalize_encoded sequence

      tmp = []
      @key.each_with_index do |k, i|
        tmp[k - 1] = sequence[i]
      end
      tmp
    end
  end

  private

  # TODO: Extract to "Validator" module/class
  def validate(key)
    key = key.to_str
    key = key.split('').map(&:to_i)

    error = 'Key values must be of 123456789' if key.sort != (1..key.size).to_a
    error = 'Key values must be unique' if key.uniq.length != key.length
    error = 'Key length must be between 2 and 9' if key.size < 2 || key.size > 9
    raise ArgumentError, error if error

    return key
  rescue NoMethodError
    raise ArgumentError, 'Key must be a string' # or quack like a string
  end

  def perform(str)
    result = []
    str.split('').each_slice(@key.size) do |sequence|
      result << yield(sequence)
    end
    result.flatten.compact.join
  end

  # Fill sequence with nil when key value is greater than sequence length
  def normalize_encoded(sequence)
    return sequence if @key.size == sequence.size

    i = 0
    sequence = @key.map do |k|
      if k > sequence.size
        nil
      else
        t = sequence[i]
        i += 1
        t
      end
    end
  end
end
