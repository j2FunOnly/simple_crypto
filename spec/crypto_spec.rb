require 'crypto'

RSpec.describe Crypto do
  subject { described_class.new key }

  describe 'decode and encode string' do
    let(:decoded) { 'Hello,_world!' }
    let(:encoded) { 'lHe,olo_wdlr!' }
    let(:key) { '312654' }

    describe '#encode' do
      it 'return encoded string' do
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
    it 'successfully' do
      decoded = 'Lorem ipsum dolor sit amet'
      (2..9).each do |i|
        crypto = Crypto.new (1..i).to_a.shuffle.join
        encoded = crypto.encode decoded
        expect(crypto.decode encoded).to eq decoded
      end
    end
  end

  describe 'key' do
    it 'should be sequence of unique numbers' do
      expect do
        described_class.new '11'
      end.to raise_error ArgumentError, 'Key values should be unique'
    end

    it 'length should be between 2 and 9' do
      expect do
        described_class.new '1234567890'
      end.to raise_error ArgumentError, 'Key length should be between 2 and 9'
    end

    it 'values should be in 123456789' do
      expect do
        described_class.new '0123'
      end.to raise_error ArgumentError, 'Key values should be in 123456789'
    end
  end
end
