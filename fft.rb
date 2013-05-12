# coding: UTF-8

module FFT
  F_signal = 5
  F_discret = 10
  W_signal = 2 * F_signal * Math::PI
  W_discret = 2 * F_discret * Math::PI

   discret_signal = []
   discret_spectr = []
   t = []
   f = []

   for i in 0..100000
         time = i.to_f / F_discret 
         discret_signal << Math.sin(time * W_signal)
         x << time
         #f << i * FD
         #ft << y[i] * Complex(Math.cos(fr[i]*i), Math.sin(fr[i]*i)).abs
   end
end
