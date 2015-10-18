require "lexigen/version"
require "matrix"
require "lexigen/state_machine"
require "lexigen/token"
require "lexigen/generator"
require "lexigen/generators/ruby_generator"

module Lexigen

  # Easily define a set of state machines and their transitions
  # @example
  # Lexigen.define do
  #   from(0).to(1).if(/\d/)
  #   from(1).to(1).if(/\d/)
  #   from(1).unless(/\d/).return_as(:integer)
  # end
  def self.define(&block)
    definition = StateMachine.new
    definition.instance_eval(&block)
    definition.to_matrix
  end

end
