# coding: UTF-8
require 'gnuplot'
require 'fft/test_signal'
require 'fft/fft_process'

class DrawFFT
  def min_arg
    0
  end

  def max_arg(counts)
    counts.size
  end

  def arg_draw_ambit(counts)
    "[#{min_arg}:#{max_arg(counts)}]"
  end
  def prepare_signal(signal = :cos_signal)
    @signal ||= TestSignal.send(signal)
  end

  def prepare_data(signal = :cos_signal)
    @fft ||= FFTProcess.new(prepare_signal(signal))
  end

  def draw_signal(signal =:cos_signal, count = TestSignal::COUNT)
    data = Digit.new(prepare_signal(signal)).discretisize(count)
    
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange arg_draw_ambit(data)
        plot.title "Cигнал"
        plot.ylabel "Значения сигнала"
        plot.xlabel "Отсчеты"

        plot.data << Gnuplot::DataSet.new([(1..count).to_a, data]) do |ds|
          ds.with = "impulses"
          ds.notitle
        end
      end
    end
  end

  def draw_cos_spectr(count = 64, f_div = 4)
    sig = TestSignal.cos_signal(f_division = f_div)
    fft = FFTProcess.new(sig, count)
    
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange arg_draw_ambit(fft.counts)
        plot.title "Спектр"
        plot.ylabel "Значения спектра"
        plot.xlabel "Отсчеты"

        plot.data << Gnuplot::DataSet.new([fft.args, fft.spectr(8)]) do |ds|
          ds.with = "impulses"
          ds.notitle
        end
      end
    end
  end

  def draw_mix_spectr(count = 64)
    sig = TestSignal.mix
    fft = FFTProcess.new(sig, count)
    
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange arg_draw_ambit(fft.counts)
        plot.title "Cигнал"
        plot.ylabel "Значения сигнала"
        plot.xlabel "Отсчеты"

        plot.data << Gnuplot::DataSet.new([fft.args, fft.spectr(8)]) do |ds|
          ds.with = "impulses"
          ds.notitle
        end
      end
    end
  end

  def draw_radio_impulse_spectr(count = 64)
    sig = TestSignal.radio_impulse1
    fft = FFTProcess.new(sig, count)
    
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange arg_draw_ambit(fft.counts)
        plot.title "Cигнал"
        plot.ylabel "Значения сигнала"
        plot.xlabel "Отсчеты"

        plot.data << Gnuplot::DataSet.new([fft.args, fft.spectr(8)]) do |ds|
          ds.with = "impulses"
          ds.notitle
        end
      end
    end
  end

  def draw_spectr(signal = :cos_signal)
    data = prepare_data(signal)

    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange arg_draw_ambit(data.counts)
        plot.title "Спектр сигнала"
        plot.ylabel "Спектральная плотность"
        plot.xlabel "Частота"

        plot.data << Gnuplot::DataSet.new([data.args, data.spectr]) do |ds|
          ds.with = "impulses"
          ds.notitle
        end
      end
    end
  end

  def draw_spectr_noise(count = 64, n = 60)
    sig = TestSignal.cos_signal_with_noise(n1 = n)
    fft = FFTProcess.new(sig, count)

    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange arg_draw_ambit(fft.counts)
        plot.title "Cигнал"
        plot.ylabel "Значения сигнала"
        plot.xlabel "Отсчеты"

        plot.data << Gnuplot::DataSet.new([fft.args, fft.spectr(8)]) do |ds|
          ds.with = "impulses"
          ds.notitle
        end
      end
    end
  end
end