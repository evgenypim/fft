# coding: UTF-8
require 'benchmark'
require 'matrix'

class FFTProcess < Function

  def initialize(signal)
    @counts = Digit.new(signal).discretisize(TestSignal::COUNT)
    @result = []
  end

  attr_reader :part_counts, :result, :counts

  def fft_by_time(vec, base)
    matrix = make_matrix(vec, [base])
    @part_counts = []

    m_m = base
    l_m = matrix.size

    matrix.each_with_index do |vec, s|
      vec.each_with_index do |count, r|
        @part_counts[r * l_m + s] = sum(0, m_m - 1) do |m|
          kernel(-r, m, m_m) * kernel(-s, m, l_m * m_m) * sum(0, l_m - 1) { |l| matrix[l][m] * kernel(-l, s, l_m) }
        end
      end
    end 

    @result += @part_counts
  end

  def fft_by_freq(vec, base)
    matrix = make_matrix(vec, [base])
    @part_counts = []

    m_m = base
    l_m = matrix.size

    matrix.each_with_index do |vec, s|
      vec.each_with_index do |count, r|
        @part_counts[r * l_m + s] = sum(0, l_m - 1) do |l|
          kernel(-l, s, l_m) * sum(0, m_m - 1) { |m| matrix[l][m] * kernel(-m, s, l_m * m_m) * kernel(-m, r, m_m) }
        end
      end
    end 

    @result += @part_counts
  end

  def sum(a, b, &block)
    (a..b).inject(0) { |res, arg| res += block.call(arg) }
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
    fft_by_time(@counts, 8)
    result.map(&:abs)
  end

  def ratio
    Benchmark.realtime { dpf(@counts) } / Benchmark.realtime { fft2(@counts) }
  end
end