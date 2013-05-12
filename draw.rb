# coding: UTF-8
require 'gnuplot'

class Draw
  Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
      plot.xrange "[0:100]"
      plot.title  "Спектр сигнала"
      plot.ylabel "Частота"
      plot.xlabel "Спектральная плотность"
      
      plot.data << Gnuplot::DataSet.new( [discret_signal, t] ) do |ds|
        ds.with = "linespoints"
        ds.notitle
      end
    end  
  end