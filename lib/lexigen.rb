require "lexigen/version"
require "matrix"
require "lexigen/state_machine"

module Lexigen

  # Easily define a set of state machines and their transitions
  # @example
  # Lexigen.define do |sm|
  #   sm.from(0).to(2).if(/d+/)
  #   sm.from(2).to(1).unless(/w+/)
  # end
  def self.define
    definition = StateMachine.new
    yield definition
    definition.to_matrix
  end
  
end
