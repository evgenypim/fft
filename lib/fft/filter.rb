# coding: UTF-8

class Filter
  def af(n = 64)
    filter.map { |counts| counts[n/2].abs }
  end

  def cos(a = 1, phi = 0, f = 0, f_discret = 256.0)
    Function.new { |n| a * Math.cos(2 * Math::PI * n * f / f_discret + phi) }
  end

  def filter(count = 64)
    (0..16).map do |f|
      fft = FFTProcess.new(cos(1,0,f, 256), count)
      fft.fft2(fft.counts)
    end
  end
end