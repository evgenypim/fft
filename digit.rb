# coding: UTF-8
class Digit < Array
  def initialize(data, sampling)
    @sampling = sampling
    super data
  end

  def sampling
    @sampling
  end
end