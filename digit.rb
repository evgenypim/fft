# coding: UTF-8
class Digit < Array
  def initialize(data, samplind)
    @samplind = samplind
    super data
  end

  def sampling
    @sampling
  end
end