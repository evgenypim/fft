# coding: UTF-8
class Digit < Array
<<<<<<< HEAD
  def initialize(data, samplind)
    @samplind = samplind
=======
  def initialize(data, sampling)
    @sampling = sampling
>>>>>>> 7811a53aee663b4f72139108b038a876bf0fea83
    super data
  end

  def sampling
    @sampling
  end
end