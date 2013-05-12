class Discret

  include Enumerable
  
  def initialize(data)
    @data = data
  end

  def length
    @data.size unless @data.nil?
  end

  def each(&block)
    @data.each do ||
      block.call(member)
    end
  end

end