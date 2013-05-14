# coding: UTF-8
require 'fft/function'

class TestSignal < Function
  def self.cos_signal(ampl = 1, phase = 0, f_division= F_DIVISION_COS)
    self.new { |n| ampl * Math.cos(2 * Math::PI * n / f_division + phase) }
  end

  def self.sin_signal(ampl = 1, phase = 0, f_division = F_DIVISION_COS)
    self.new { |n| ampl * Math.sin(2 * Math::PI * n / f_division + phase) }
  end

  def self.rect_signal(ampl = 1, q = 1 , ti = 1)
    # q = f_division / (f_disret * ti)
    ## TODO
  end

  def self.f_signal(f_division, f_discret)
    f_discret / f_division
  end
end