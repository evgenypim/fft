# coding: UTF-8
require './digit'

class Function  
  include Math

  F_DIVISION_COS = 10
  COUNT = 128

  def initialize(count = COUNT, &block)
    @function = block
    @count = COUNT
  end

  def result(arg)
    @function[arg] unless @function.nil?
  end

  def discretisize
    data = (1..@count).map { |n| result(n) }
    Digit.new data
  end

  def discret_data
    @discret_data ||= discretisize
  end
end