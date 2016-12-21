require 'crypto'
require 'pry'

RSpec.describe Crypto do
  subject { described_class.new key }

  describe 'decode and encode phrase' do
    let(:decoded) { 'Hello,_world!' }
    let(:encoded) { 'lHe,olo_wdlr!' }
    let(:key) { '312654' }

    describe '#encode' do
      it 'return ecoded string' do
        expect(subject.encode decoded).to eq encoded
      end
    end

    describe '#decode' do
      it 'return decoded string' do
        expect(subject.decode encoded).to eq decoded
      end
    end
  end

  describe 'encode and decode string with random key' do
    let(:key) { (1..rand(1..9)).to_a.shuffle.join }
    let(:decoded) { 'Lorem ipsum dolor sit amet' }
    let(:encoded) { subject.encode decoded }

    it 'successfully' do
      expect(subject.decode encoded).to eq decoded
    end
  end
end
