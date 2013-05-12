# coding: UTF-8
require 'gnuplot'
require './fft'

class DrawFFT
  function = Function.initialize_cos_signal
  fft = FFT.new(function)

  ARG_MIN = 0
  ARG_MAX = 10000

  Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
      plot.xrange "[#{fft.min_arg}:#{fft.max_arg}]"
      plot.title  "Спектр сигнала"
      plot.ylabel "Спектральная плотность"
      plot.xlabel "Частота"
      
      plot.data << Gnuplot::DataSet.new([fft.args, fft.signal]) do |ds|
        ds.with = "impulses"
        ds.notitle
      end
    end  
  end
end