# coding: utf-8

require 'spec_helper'

describe TestSignal do
  describe '#cos_signal' do
    subject {TestSignal.cos_signal}
    it { should be_a_kind_of TestSignal }
  end
end