class Function

  def initialize(&block)
    @function = block
  end

  def result(t)
    @function[t] unless @function.nil?
  end

  def discret(count, freq_discret)
    (1..count).map { |x| @function[x/freq_discret] } unless @function.nil?
  end

end