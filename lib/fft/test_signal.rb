# coding: UTF-8
require 'fft/function'

class TestSignal < Function
  def self.cos_signal(ampl = 1, phase = 0, f_division = F_DIVISION_COS)
    self.new { |n| ampl * Math.cos(2 * Math::PI * n / f_division + phase) }
  end
end