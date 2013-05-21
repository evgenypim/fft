# coding: UTF-8
require 'benchmark'
require 'matrix'

class FFTProcess

  def initialize(signal)
    @counts = signal.discret_data if signal.is_a? Function
    @counts = signal if signal.is_a? Digit
    @part_counts = Array.new
    @result = Array.new
  end

  attr_reader :part_counts, :result, :counts
  

  def fft(vec, bases)
    matrix = make_matrix(vec, bases.first)
    if bases.size == 1
      partition_dpf(matrix)      
    else
      matrix.each { |v| fft(v, bases[1..bases.size]) }
    end
  end

  def partition_dpf(matrix)
    part_counts = Array.new
    trans_matrix = matrix.transpose

    l_m = matrix.size
    m_m = matrix.first.size

    trans_matrix.each_with_index do |vec, index|
      vec.each_with_index do |count, vec_index|

        trans_matrix[index][vec_index] = sum(0, m_m - 1) do |m|
          kernel(-index, m ,m_m) * kernel(-vec_index, m , l_m*m_m) * sum(0, l_m - 1) { |l| matrix[l][m] * kernel(-l , vec_index, l_m) }
        end

        part_counts[index * l_m + vec_index] = trans_matrix[index][vec_index]
      end
    end 

    result.concat part_counts
  end

  def sum(a, b, &block)
    (a..b).inject { |res, arg| res += block.call(arg) }
  end

  def fft2(vec )
    return vec if vec.size <= 1

    even = Array.new(vec.size / 2) { |i| vec[2 * i] }
    odd = Array.new(vec.size / 2) { |i| vec[2 * i + 1] }

    fft_even = fft2(even)
    fft_odd = fft2(odd)

    fft_even.concat(fft_even)
    fft_odd.concat(fft_odd)

    Array.new(vec.size) {|i| fft_even[i] + fft_odd [i] * omega(-i, vec.size)}
  end

  def dpf(vec)
    Array.new(vec.size) { |i| find_one_count_of_dpf(vec, i) }
  end

  def omega(k, n)
      Math::E ** Complex(0, 2 * Math::PI * k / n)
  end

  def kernel(k, n, size)
    Math::E ** Complex(0, 2 * Math::PI * k * n / size)
  end

  def find_one_count_of_dpf(vec, n)
    index = 0
    vec.inject { |sum, count|  index = index + 1; sum = sum + count * kernel(-n, index, vec.size) }
  end

  def prepare_matrix_data(data, base)
    return data if base.empty?

    parts_count = base.first
    step = data.size / parts_count

    (0..parts_count-1).map { |i| prepare_matrix_data(data[i * step, step], base[1..base.size]) }
  end

  def make_matrix(vec, base)
    prepare_matrix_data(vec, [base])
  end

  def args
    (0..@counts.size - 1).to_a
  end

  def spectr
    fft(@counts, [2])

    result.map(&:abs)
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

  def ratio
    Benchmark.realtime { dpf(@counts) } / Benchmark.realtime { fft(@counts, [2]) }
  end
end