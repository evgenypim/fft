# coding: UTF-8

# Public: Класс, реализующий дискретные отсчеты сигнала
class Digit < Array
  def initialize(function)
    raise 'argument must be an instance of Function class' unless function.is_a? Function

    @function = function
  end

  attr_accessor :function, :data

  # Public: Метод дискетизирует функцию с указанной частотой дискретизации
  #
  # Examples
  #
  #  f = Function.new { |x| Math.cos(x) }
  #  d = Digit.new(f).discretisize(1) #=> [1]
  #
  # Returns Array
  def discretisize(count)
    @data ||= (0..count-1).map { |n| @function.result(n) }
  end
end