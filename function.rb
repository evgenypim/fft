class Function

  def initialize(&block)
    @function = block
  end

  def result(arg)
    @function[arg] unless @function.nil?
  end

  def discret(count, freq_discret)
    (1..count).map { |arg| @function[arg/freq_discret] } unless @function.nil?
  end

end