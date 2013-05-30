# coding: UTF-8
class DrawAF < DrawFFT
  def draw_cf(count = 64, f_discret = 256, k = 0)
    cf = Filter.new.cf(count, f_discret, k)

    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange "[0:#{count/2}]"
        plot.title "ФЧХ"
        plot.ylabel "ФЧХ"
        plot.xlabel "Отсчеты"

        plot.data << Gnuplot::DataSet.new([(0..count/2).to_a, cf]) do |ds|
          ds.with = "lines"
          ds.notitle
        end
      end
    end
  end

  def draw_af(count = 64, f_discret = 256, k = 0)
    af = Filter.new.af(count, f_discret, k)

    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange "[0:#{count/2}]"
        plot.title "АЧХ"
        plot.ylabel "АЧХ"
        plot.xlabel "Отсчеты"

        plot.data << Gnuplot::DataSet.new([(0..count/2).to_a, af]) do |ds|
          ds.with = "lines"
          ds.notitle
        end
      end
    end
  end
end