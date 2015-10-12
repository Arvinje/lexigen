require "spec_helper"

describe Lexigen::Token do
  context 'instance attributes' do
    let(:token) { Lexigen::Token.new }
    subject { token }
    it { is_expected.to respond_to :word }
    it { is_expected.to respond_to :word= }
    it { is_expected.to respond_to :row }
    it { is_expected.to respond_to :row= }
    it { is_expected.to respond_to :col }
    it { is_expected.to respond_to :col= }
    it { is_expected.to respond_to :type }
    it { is_expected.to respond_to :type= }
    it { is_expected.to respond_to :block_order }
    it { is_expected.to respond_to :block_order= }
    it { is_expected.to respond_to :block_number }
    it { is_expected.to respond_to :block_number= }

    it 'sets an empty string as word on initiation' do
      expect(token.word).to eql ''
    end
  end
end
