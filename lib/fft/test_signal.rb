# coding: UTF-8
require 'fft/function'

# Public: Класс, реализующий джентельменский набор сигналов
class TestSignal < Function

  # Public: Метод создает тестовый косинусоидальный сигнал
  #
  # count       - Fixnum, колличество отсчетов при дискретизации, по умолчанию 128
  # ampl        - Fixnum, амплитуда сигнала
  # phase       - Fixnum, начальная фаза сигнала
  # f_division  - Fixnum, отношение частоты дисректизации к частоте сигнала
  #
  # Examples
  #
  #   TestSignal.cos_signal(1, 0, 4)
  #
  # Returns TestSignal
  def self.cos_signal(count = COUNT, ampl = 1, phase = 0, f_division= F_DIVISION_COS)
    self.new(count) { |n| ampl * Math.cos(2 * Math::PI * n / f_division + phase) }
  end

  # Public: Метод создает тестовый cинусоидальный сигнал
  #
  # count       - Fixnum, колличество отсчетов при дискретизации, по умолчанию 128
  # ampl        - Fixnum, амплитуда сигнала
  # phase       - Fixnum, начальная фаза сигнала
  # f_division  - Fixnum, отношение частоты дисректизации к частоте сигнала
  #
  # Examples
  #
  #   TestSignal.sin_signal(1, 0, 4)
  #
  # Returns TestSignal
  def self.sin_signal(count = COUNT, ampl = 1, phase = 0, f_division = F_DIVISION_COS)
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