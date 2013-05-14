# coding: UTF-8

class Function

  F_DIVISION_COS = 10
  COUNT = 128

  def initialize(count = COUNT, &block)
    @function = block
    @count = count
  end

  def result(arg)
    @function[arg] unless @function.nil?
  end

  def discretisize
    data = (0..@count-1).map { |n| result(n) }
    Digit.new data
  end

  def discret_data
    @discret_data ||= discretisize
  end
end