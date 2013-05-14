# coding: UTF-8
require 'gnuplot'
require 'fft/test_signal'
require 'fft/fft_process'

module DrawFFT
  def self.prepare_signal(signal)
    @signal ||= TestSignal.try(signal)
  end

  def self.prepare_data
    @fft ||= FFTProcess.new(prepare_signal(:cos_signal))
  end

  def self.draw_spectr
    data = prepare_data
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange @data.arg_draw_ambit
        plot.title "Спектр сигнала"
        plot.ylabel "Спектральная плотность"
        plot.xlabel "Частота"

        plot.data << Gnuplot::DataSet.new([@data.args, @data.spectr]) do |ds|
          ds.with = "impulses"
          ds.notitle
        end
      end
    end
  end

end