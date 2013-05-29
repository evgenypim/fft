# coding: UTF-8
class DrawAF < DrawFFT
  def draw_af(af = Filter.new.af)
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.xrange "[0:17]"
        plot.title "АЧХ"
        plot.ylabel "АЧХ"
        plot.xlabel "Отсчеты"

        plot.data << Gnuplot::DataSet.new([(0..16).to_a, af]) do |ds|
          ds.with = "impulses"
          ds.notitle
        end
      end
    end
  end
end