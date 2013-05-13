# coding: UTF-8
require "./function"

class TestSignal < Function
  def self.initialize_cos_signal(ampl = 1, phase = 0, f_division = F_DIVISION_COS)
    TestSignal.new { |n| ampl * Math.cos(2 * Math::PI  * n  /  f_division + phase) }
  end
end