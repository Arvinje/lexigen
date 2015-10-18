require "spec_helper"

describe Lexigen::RubyGenerator do

  describe ".initialize" do
    let(:state_machine) { Lexigen::StateMachine.new }
    it "sets the received state machine to an instance variable" do
      ruby_generator = Lexigen::RubyGenerator.new(state_machine)
      expect(ruby_generator.instance_variable_get(:@state_machine)).to eql state_machine
    end
  end

end
