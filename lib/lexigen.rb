require "lexigen/version"
require "matrix"
require "lexigen/state_machine"
require "lexigen/token"

module Lexigen

  # Easily define a set of state machines and their transitions
  # @example
  # Lexigen.define do |sm|
  #   sm.from(0).to(1).if(/\d/)
  #   sm.from(1).to(1).if(/\d/)
  #   sm.from(1).unless(/\d/).return_as(:integer)
  # end
  def self.define
    definition = StateMachine.new
    yield definition
    definition.to_matrix
  end

end
