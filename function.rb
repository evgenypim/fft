# coding: UTF-8
require './digit'

class Function  
  include Math

  def initialize(f_signal = 20, f_discret = 50, count = 128, &block)
    @f_discret = f_discret
    @f_signal = f_signal
    @function = block
    @count = count
  end

  def self.initialize_cos_signal(ampl = 1, phase = 0)
    f_signal = 20
    f_discret = 200
    count = 128
    omega = 2 * Math::PI * f_signal
    Function.new(f_signal, f_discret, count) { |t| ampl * Math.cos(omega * t + phase) }
  end

  def result(arg)
    @function[arg] unless @function.nil?
  end

  def discretisize
    data = (1..@count).map { |x| result(Rational(x, @f_discret)) }
    Digit.new data, @f_discret
  end

  def discret_data
    @discret_data ||= discretisize
  end
end