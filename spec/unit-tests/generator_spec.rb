require "spec_helper"

describe Lexigen::Generator do
  describe ".ruby" do
    let(:state_machine) { Lexigen::StateMachine.new }

    it "creates a new RubyGenerator object and calls generate on it" do
      ruby_generator = double
      allow(Lexigen::RubyGenerator).to receive(:new).with(state_machine).and_return(ruby_generator)
      allow(ruby_generator).to receive(:generate).and_return(:generated_lexer_object)
      expect(Lexigen::Generator.ruby(state_machine)).to eql :generated_lexer_object
    end
  end
end
