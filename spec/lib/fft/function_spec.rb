require 'spec_helper'

describe Function do

  let(:count) { 64 }
  let(:f_division) { 10 }
  let(:func) do
    Function.new(count) { |n| Math.cos(2 * Math::PI * n / f_division ) }
  end

  subject { func }

  describe '#result' do
    subject { func.result(0) }
    it { should eq 1 }
  end

  describe '#discretisize' do
    subject { func.discretisize }

    before { described_class.any_instance.should_receive(:result).exactly(count).times }
    it { should be_kind_of Digit }
  end

  describe '#discret_data' do
    subject { func.discret_data }

    before { described_class.any_instance.should_receive(:discretisize).and_call_original }
    it { should be_kind_of Digit }
  end
end