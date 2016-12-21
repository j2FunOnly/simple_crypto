class Crypto
  def initialize(key)
    @key = validate key
  end

  def encode(str)
    perform str do |sentence|
      @key.map do |i|
        sentence[i - 1]
      end
    end
  end

  def decode(str)
    perform str do |sentence|
      sentence = normalize_decoded sentence

      tmp = []
      @key.each_with_index do |k, i|
        tmp[k - 1] = sentence[i]
      end
      tmp
    end
  end

  private

  # TODO: SMELL CODE: Extract to "Validator" module/class
  def validate(key)
    key = key.to_str
    key = key.split('').map(&:to_i)

    error = 'Key values must be of 123456789' if key.sort != (1..key.size).to_a
    error = 'Key values must be unique' if key.uniq.length != key.length
    error = 'Key length must be between 2 and 9' if key.size < 2 || key.size > 9
    raise ArgumentError, error if error

    return key
  rescue NoMethodError
    raise ArgumentError, 'Key must be a string'
  end

  def perform(str)
    result = []
    str.split('').each_slice(@key.size) do |sentence|
      result << yield(sentence)
    end
    result.flatten.compact.join
  end

  # fill sentence with nil when key value if greater then sentence length
  def normalize_decoded(sentence)
    i = 0
    sentence = @key.map do |k|
      if k > sentence.size
        nil
      else
        t = sentence[i]
        i += 1
        t
      end
    end
  end
end
