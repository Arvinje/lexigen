require "spec_helper"
require "matrix"

describe Lexigen::StateMachine do

  describe "#from" do
    let(:state_machine) { Lexigen::StateMachine.new }

    it "adds the statring state to states array" do
      state_machine.from(0)
      expect(state_machine.instance_variable_get(:@states)[0][0]).to eql 0
    end

    it "adds some statring states to states array" do
      state_machine.from(1)
      state_machine.from(2)
      expect(state_machine.instance_variable_get(:@states)[0][0]).to eql 1
      expect(state_machine.instance_variable_get(:@states)[1][0]).to eql 2
    end
  end

  describe "#to" do
    let(:state_machine) { Lexigen::StateMachine.new }

    it "adds the final state to states array" do
      state_machine.from(0).to(3)
      expect(state_machine.instance_variable_get(:@states)).to include [0,3]
    end

    it "adds some final states to states array" do
      state_machine.from(4).to(2)
      state_machine.from(2).to(6)
      expect(state_machine.instance_variable_get(:@states)).to include [4,2]
      expect(state_machine.instance_variable_get(:@states)).to include [2,6]
    end
  end

  describe "#if" do
    let(:state_machine) { Lexigen::StateMachine.new }

    it "adds the passed condition to the if_conditions array" do
      state_machine.from(0).to(2).if("condition1")
      expect(state_machine.instance_variable_get(:@if_conditions)[0]).to eql "condition1"
    end

    it "adds some passed conditions to the if_conditions array" do
      state_machine.from(0).to(2).if("condition1")
      state_machine.from(2).to(3).if("condition2")
      expect(state_machine.instance_variable_get(:@if_conditions)[0]).to eql "condition1"
      expect(state_machine.instance_variable_get(:@if_conditions)[1]).to eql "condition2"
    end
  end

  describe "#unless" do
    let(:state_machine) { Lexigen::StateMachine.new }

    it "adds the passed condition to the unless_conditions array" do
      state_machine.from(0).to(2).unless("condition1")
      expect(state_machine.instance_variable_get(:@unless_conditions)[0]).to eql "condition1"
    end

    it "adds some passed conditions to the unless_conditions array" do
      state_machine.from(0).to(2).unless("condition1")
      state_machine.from(2).to(3).unless("condition2")
      expect(state_machine.instance_variable_get(:@unless_conditions)[0]).to eql "condition1"
      expect(state_machine.instance_variable_get(:@unless_conditions)[1]).to eql "condition2"
    end
  end

  describe "#return_as" do
    let(:state_machine) { Lexigen::StateMachine.new }

    it "adds a return state to return_tokens array" do
      state_machine.from(0).if(/\d/).return_as(:integer)
      expect(state_machine.return_tokens.first).to eql({ if: /\d/, unless: nil, type: :integer })
    end

    it "adds some return states to return_tokens array" do
      state_machine.from(4).if(/\w/).return_as(:float)
      state_machine.from(2).unless(/\d/).return_as(:integer)
      expect(state_machine.return_tokens[4]).to eql({ if: /\w/, unless: nil, type: :float })
      expect(state_machine.return_tokens[2]).to eql({ if: nil, unless: /\d/, type: :integer })
    end
  end

  describe "#to_matrix" do
    let(:state_machine) { Lexigen::StateMachine.new }
    before do
      state_machine.from(0).to(4).if("ifcon1")
      state_machine.from(4).to(3).unless("unlesscon1")
      state_machine.from(4).to(4).if("ifcon2")
      state_machine.from(4).to(0).unless("unlesscon2")
    end

    it "transforms the arrays to a matrix" do
      expect(state_machine.to_matrix.matrix).to eql Matrix[ [nil,nil,nil,nil,{if: "ifcon1", unless: nil}], [nil,nil,nil,nil,nil],
                                                     [nil,nil,nil,nil,nil], [nil,nil,nil,nil,nil],
                                                     [{if: nil, unless: "unlesscon2"},nil,nil,{if: nil, unless: "unlesscon1"},
                                                       {if: "ifcon2", unless: nil} ]]
    end
  end

end
