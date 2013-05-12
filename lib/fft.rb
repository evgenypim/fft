# coding: UTF-8
require "./function"

class FFT
  def initialize(signal)
    @counts = signal.discret_data if signal.is_a? Function
    @counts = signal if signal.is_a? Digit
  end

  # Solve "vec = fft_matrix * beta" for beta (modulo a constant.)
  # (Divide result by Math::sqrt(vec.size) to preserve length.)
  # vec.size is assumed to be a power of 2.
  #
  # Example use:  puts fft([1,1,1,1])
  #
  def fft(vec )
      return vec if vec.size <= 1

      even = Array.new(vec.size / 2) { |i| vec[2 * i] }
      odd  = Array.new(vec.size / 2) { |i| vec[2 * i + 1] }

      fft_even = fft(even)
      fft_odd  = fft(odd)

      fft_even.concat(fft_even)
      fft_odd.concat(fft_odd)

      Array.new(vec.size) {|i| fft_even[i] + fft_odd [i] * omega(-i, vec.size)}
  end

  def dpf(vec)
    Array.new(vec.size) { |i| vec[i] * omega(-i, vec.size) }
  end

  # calculate individual element of FFT matrix:  (e ^ (2 pi i k/n))
  # fft_matrix[i][j] = omega(i*j, n)
  #
  def omega(k, n)
      Math::E ** Complex(0, 2 * Math::PI * k / n)
  end

  def make_matrix(data, base)
    return data if base.empty?
    parts_count = base.first
    step = data.size / parts_count
    (0..parts_count-1).map { |i| make_matrix(data[i*step, step], base[1..base.size]) }
  end

  def args
    step = @counts.sampling.to_f / @counts.size
    (0..@counts.size - 1).map { |i| i * step}
  end

  def signal
    fft(@counts)
    # @counts
  end

  def min_arg
    0
  end

  def max_arg
    @counts.sampling
  end

end
