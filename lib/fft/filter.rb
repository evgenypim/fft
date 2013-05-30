# coding: UTF-8

class Filter
  def af(count = 64, f_discret = 256, k = 0)
    filter(count, f_discret).map { |counts| counts[k].abs }
  end

  def cf(count = 64, f_discret = 256, k = 0)
    filter(count, f_discret).map { |counts| counts[k].phase }
  end

  def cos(a = 1, phi = 0, f = 0, f_discret = 256.0)
    Function.new { |n| a * Math.cos(2 * Math::PI * n * f / f_discret + phi) }
  end

  def filter(count = 64, f_discret = 256)
    @result = []

    (-f_discret / 2..f_discret / 2).map do |f|
      fft = FFTProcess.new(cos(1,0,f, 256.0), count)
      @result << fft.fft2(fft.counts)
    end
    @result
  end
end