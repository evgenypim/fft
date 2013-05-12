# coding: UTF-8
require "function"

module FFT
  F_signal = 5
  F_discret = 10
  W_signal = 2 * F_signal * Math::PI
  W_discret = 2 * F_discret * Math::PI
  ARG_MIN = 0
  ARG_MAX = 100

   discret_signal = []
   discret_spectr = []
   t = []
   f = []

   def initialize_signal 
     @signal = Function.new { |t| Math.sin(W_signal * t) }
   end

   def self.discret_signal
     discret_signal
   end

   def self.discret_spectr
     discret_spectr 
   end

   def self.time
     t
   end

   def self.freq
     f
   end
end
