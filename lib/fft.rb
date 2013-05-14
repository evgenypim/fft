# coding: UTF-8
require './function'
require 'benchmark'

class FFT

  def initialize(signal)
    @counts = signal.discret_data if signal.is_a? Function
    @counts = signal if signal.is_a? Digit
  end

  def fft2(vec )
    return vec if vec.size <= 1

    even = Array.new(vec.size / 2) { |i| vec[2 * i] }
    odd  = Array.new(vec.size / 2) { |i| vec[2 * i + 1] }

    fft_even = fft2(even)
    fft_odd  = fft2(odd)

    fft_even.concat(fft_even)
    fft_odd.concat(fft_odd)

    Array.new(vec.size) {|i| fft_even[i] + fft_odd [i] * omega(-i, vec.size)}
  end

  def dpf(vec)
    Array.new(vec.size) { |i| find_one_count_of_dpf(vec, i) }
  end

  # calculate individual element of FFT matrix:  (e ^ (2 pi i k/n))
  # fft_matrix[i][j] = omega(i*j, n)
  #
  def omega(k, n)
      Math::E ** Complex(0, 2 * Math::PI * k / n)
  end

  def kernel(k, n, size)
    Math::E ** Complex(0, 2 * Math::PI * k * n / size)
  end

  def find_one_count_of_dpf(vec, n)
    sum = 0
    vec.each_with_index { |count, index| sum = sum + count * kernel(n, index, vec.size) }

    sum
  end

  def make_matrix(data, base)
    return data if base.empty?

    parts_count = base.first
    step = data.size / parts_count

    (0..parts_count-1).map { |i| make_matrix(data[i * step, step], base[1..base.size]) }
  end

  def args
    (0..@counts.size - 1).to_a
  end

  def spectr
    dpf(@counts).map(&:abs)
  end

  def min_arg
    0
  end

  def max_arg
    @counts.size
  end

  def arg_draw_ambit
    "[#{min_arg}:#{max_arg}]"
  end

  def speed_koef
    Benchmark.realtime { dpf(@counts) } / Benchmark.realtime { fft2(@counts) }
  end
end
