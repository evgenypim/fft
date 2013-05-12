# coding: UTF-8
require 'gnuplot'
require './fft'

class Draw
  include FFT

  ARG_MIN = 0
  ARG_MAX = 100

  Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
      plot.xrange "[#{ARG_MIN}:#{ARG_MAX}]"
      plot.title  "Спектр сигнала"
      plot.ylabel "Частота"
      plot.xlabel "Спектральная плотность"
      
      plot.data << Gnuplot::DataSet.new([[1,2], [1,2]]) do |ds|
        ds.with = "linespoints"
        ds.notitle
      end
    end  
  end
end