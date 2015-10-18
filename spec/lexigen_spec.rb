require 'spec_helper'
require "matrix"

describe Lexigen do
  it 'has a version number' do
    expect(Lexigen::VERSION).not_to be nil
  end

  describe ".define" do
    before do
      @state_machine = Lexigen.define do
        from(0).to(2).if(/d+/)
        from(2).to(1).unless(/w+/)
      end
    end

    it "returns the constructed state machine" do
      expect(@state_machine.matrix).to eql Matrix[ [nil,nil,{if: /d+/, unless: nil}],
                                                   [nil,nil,nil], [nil,{if: nil, unless: /w+/},nil] ]
    end
  end

end
