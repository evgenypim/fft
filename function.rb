class Function

  def initialize(&block)
    @function = block
  end

  def result(arg)
    @function[arg] unless @function.nil?
  end

  def discret(count, freq_discret)
    data = (1..count).map { |x| @function[x/freq_discret] } unless @function.nil?
    @discret_data = Discret.new data, freq_discret
  end

end