# coding: UTF-8
class Function  
  include Math

  def initialize(f_signal = 20, f_discret = 50, count = 128, &block)
    @f_discret = f_signal
    @f_signal = f_discret
    @function = block
  end

  def self.initialize_cos_signal(ampl = 1, phase = 0)
    f_signal = 20
    f_discret = 50
    count = 128
    Function.new(f_signal, f_discret, count) { |t| ampl * cos(2 * PI * f_signal * t + phase) }
  end

  def result(arg)
    @function[arg] unless @function.nil?
  end

  def discretisize
    data = (1..count).map { |x| result(x/@f_discret) } unless @function.nil?
    Digit.new data, @f_discret
  end

  def discret_data
    @discret_data ||= discretisize
  end
end