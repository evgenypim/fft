# coding: UTF-8
require 'gnuplot'
require './test_signals'
require './fft'

class DrawFFT
  function = TestSignals.cos_signal
  fft = FFT.new(function)

  Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
      plot.xrange fft.arg_draw_ambit
      plot.title  "Спектр сигнала"
      plot.ylabel "Спектральная плотность"
      plot.xlabel "Частота"

      plot.data << Gnuplot::DataSet.new([fft.args, fft.spectr]) do |ds|
        ds.with = "impulses"
        ds.notitle
      end
    end
  end
end