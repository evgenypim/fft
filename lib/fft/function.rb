# coding: UTF-8

# Public: Клас реализующий работу с функциямии
class Function

  def self.sum(a, b, &block)
    (a..b).inject(0) { |res, arg| res += block.call(arg) }
  end

  # Public: Инициализатор функции (НАМ В ЛЮБОМ СЛУЧАЕ НУЖНА ЧАСТОТА ДИСКРИТИЗАЦИИ!!! ГДЕ-ТО НО НУЖНА!!!)
  #
  # count - Fixnum, колличество отсчетов при дискретизации, по умолчанию 128
  # block - block, тело функции, от одного аргумента
  #
  # Examples
  #
  #   Function.new { |x| Math.cos(x) }
  #
  # Returns Function
  def initialize(&block)
    @function = block
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
  def result(*arg)
    @function[*arg] unless @function.nil?
  end
  
  # Public: Вычисляет композицию функций
  #
  # other - Function, функция, на которую надо умножить исходную 
  #
  # Returns Function
  def *(other)
    Function.new { |x, y| self.result(x)*other.result(y)}
  end
end