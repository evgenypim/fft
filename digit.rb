# coding: UTF-8
class Digit

  include Enumerable
  
  def initialize(data, freq_discret)
    @data = data
    @freq_discret = freq_discret2
  end

  def length
    @data.size unless @data.nil?
  end

  def each(&block)
    @data.each do |count|
      block.call(count)
    end
  end

end