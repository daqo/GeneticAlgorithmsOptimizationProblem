class FloatUtility
  def FloatUtility.random_float_in_range(min, max)
    rand * (max - min) + min
  end

  def FloatUtility.encode_float(number, num_bits_floats, a, b)
    ((number - a) / ((b - a).to_f / (2 ** num_bits_floats - 1))).round.to_s(2).rjust(num_bits_floats, '0')
  end

  def FloatUtility.decode_float(bit_string, num_bits_floats, a, b)
    bit_string.to_i(2) * ((b - a).to_f / (2 ** num_bits_floats - 1)) + a
  end

  def FloatUtility.halve(str)
    boundary = str.length / 2
    head = str.slice(0, boundary)
    tail = str.slice(boundary, str.length)
    return head, tail
  end
end