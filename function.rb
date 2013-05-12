class Function

  def initialize(&block)
    @function = block
  end

  def result(arg)
    @function[arg] unless @function.nil?
  end

  def discretisize(count, freq_discret)
    data = (1..count).map { |x| @function[x/freq_discret] } unless @function.nil?
    @discret_data = Digit.new data, freq_discret
  end

  def discret_data
    @discret_data unless @discret_data.nil?
  end

protected


end