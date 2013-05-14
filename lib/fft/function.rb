# coding: UTF-8

# Public: Клас реализующий работу с функциямии
class Function

  # Public: Дефолное значение отношения частот дискретизации и сигнала(НЕ ПОНИМАЮ ПОЧЕМУ ОНО ТУТ)
  F_DIVISION_COS = 10

  # Public: Дефолное значение колличества отсчетов сигнала
  COUNT = 128

  # Public: Инициализатор функции (НАМ В ЛЮБОМ СЛУЧАЕ НУЖНА ЧАСТОТА ДИСКРИТИЗАЦИИ!!! ГДЕ-ТО НО НУЖНА!!!)
  #
  # count - Fixnum, колличество отсчетов при дискретизации, по умолчанию 128
  # block - block, тело функции, от одного аргумента
  #
  # Examples
  #
  #   Function.new(10) { |x| Math.cos(x) }
  #
  # Returns Function
  def initialize(count = COUNT, &block)
    @function = block
    @count = count
  end

  # Public: Метод возвращает значение функции в указаной точке
  #
  # arg - Точка в которой считается значение функции
  #
  # Examples
  #
  # f = Function.new(10) { |x| Math.cos(x) }
  # f.result(0) # => 1
  #
  # Returns Function
  def result(arg)
    @function[arg] unless @function.nil?
  end

  # Public: Метод дискетизирует функцию с указанной частотой дискретизации
  #
  # Examples
  #
  #  f = Function.new(1) { |x| Math.cos(x) }
  #  f.discretisize #=> [1]
  #
  # Returns Digit
  def discretisize
    data = (0..@count-1).map { |n| result(n) }
    Digit.new data
  end

  # Public: Метод возвращает дискретные отсчеты функции
  #
  # Examples
  #
  #  f = Function.new(1) { |x| Math.cos(x) }
  #  f.discret_data #=> [1]
  #
  # Returns Digit
  def discret_data
    @discret_data ||= discretisize
  end
end