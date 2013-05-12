# coding: UTF-8
require 'gnuplot'

class FFT
  Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
      plot.xrange "[0:100]"
      plot.title  "График функции"
      plot.ylabel "аргумент х"
      plot.xlabel "функция sin(x)"
      
      F_signal = 5
      F_discret = 10
      W_signal = 2 * F_signal * Math::PI
      W_discret = 2 * F_discret * Math::PI
    
      discret_signal = []
      x = []
      f = []
      discret_spectr = []
      
       for i in 0..100000
         time = i.to_f / F_discret 
         discret_signal << Math.sin(time * W_signal)
         x << time
         #f << i * FD
         #ft << y[i] * Complex(Math.cos(fr[i]*i), Math.sin(fr[i]*i)).abs
       end       
       
      plot.data << Gnuplot::DataSet.new( [discret_signal, x] ) do |ds|
        ds.with = "linespoints"
        ds.notitle
      end
    end  
  end
end
