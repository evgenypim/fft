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
    # matrix = make_matrix(vec, bases.first)
    # if bases.size == 1
    #   cool_dpf(matrix)      
    # else
    #   matrix.each { |v| fft(v, bases[1..bases.size]) }
    # end

  end

  # def cool_dpf(matrix)
  #   result + dpf(matrix.first)
  # end

  def partition_dpf(vec, base)
    matrix = make_matrix(vec, base)
    part_counts = Array.new

    m_m = base
    l_m = matrix.size

    matrix.each_with_index do |vec, index_str|
      vec.each_with_index do |count, index_element|
        part_counts[index_str * l_m + index_element] = sum(0, m_m - 1) do |m|
          kernel(-index_str, m ,m_m) * kernel(-index_element, m , l_m * m_m) * sum(0, l_m - 1) { |l| matrix[l][m] * kernel(-l, index_element, l_m) }
        end
      end
    end 

    result + part_counts
  end

  def sum(a, b, &block)
    (a..b).inject { |res, arg| res += block.call(arg) }
  end

  def fft2(vec)
    size = vec.size

    return vec if size <= 1

    makaka_flag = Math.log(size)/Math.log(2) 

    raise "Размерность - степень двойки, тупая макака" unless makaka_flag == makaka_flag.to_i

    even = Array.new(size / 2) { |i| vec[2 * i] }
    odd = Array.new(size / 2) { |i| vec[2 * i + 1] }

    fft_even = fft2(even)
    fft_odd = fft2(odd)

    fft_even.concat(fft_even)
    fft_odd.concat(fft_odd)

    Array.new(vec.size) { |i| fft_even[i] + fft_odd [i] * kernel_fft2(-i, size) }
  end

  def dpf(vec)
    Array.new(vec.size) { |i| sum(0, vec.size - 1) { |k| vec[k] * kernel(-k, i, vec.size) } }
  end

  def kernel_fft2(k, n)
      Math::E ** Complex(0, 2 * Math::PI * k / n)
  end

  def kernel(k, count, size)
    Math::E ** Complex(0, 2 * Math::PI * k * count / size)
  end

  def make_matrix(vec, bases)
    return vec if bases.empty?  

    base = bases.pop

    raise "придурок пытается разделить неразделимое" if vec.size % base !=0
    count = vec.size / base

    raise "придурок вышел за границы" if count == 0

    temp = (0..count-1).map { |i| vec[i * base, base] }

    make_matrix(temp, bases)
  end

  def args
    (0..@counts.size - 1).to_a
  end

  def spectr
    dpf(@counts).map(&:abs)

    #result.map(&:abs)
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
    Benchmark.realtime { dpf(@counts) } / Benchmark.realtime { fft2(@counts) }
  end
end