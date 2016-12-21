require 'crypto'
require 'pry'

RSpec.describe Crypto do
  describe 'decode and encode phrase' do
    let(:decoded) { 'Hello,_world!' }
    let(:encoded) { 'lHe,olo_wdlr!' }
    let(:key) { '312654' }
    subject { described_class.new key }

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
end
