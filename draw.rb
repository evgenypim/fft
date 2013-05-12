# coding: UTF-8
require 'gnuplot'

class Draw
  include FFT

  Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
      plot.xrange "[#{FFT::ARG_MIN}:#{FFT::ARG_MAX}]"
      plot.title  "Спектр сигнала"
      plot.ylabel "Частота"
      plot.xlabel "Спектральная плотность"
      
      plot.data << Gnuplot::DataSet.new([FFT.discret_signal, FFT.t]) do |ds|
        ds.with = "linespoints"
        ds.notitle
      end
    end  
  end