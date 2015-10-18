module Lexigen
  class StateMachine
    attr_reader :matrix, :return_tokens

    def initialize
      @states = []
      @if_conditions = []
      @unless_conditions = []
      @return_tokens = []
    end

    # The starting state of transition
    def from(state)
      @states << [state]
      self
    end

    # The final state of transition
    def to(state)
      @states.last << state
      self
    end

    # Respective if-condition of each transition
    def if(condition)
      @if_conditions[@states.length - 1] = condition
      self
    end

    # Respective unless-condition of each transition
    def unless(condition)
      @unless_conditions[@states.length - 1] = condition
      self
    end

    # Makes a hash containing returning types, conditions and state
    def return_as(token_type)
      state_position = @states.last.first
      @return_tokens[state_position] = { if: @if_conditions[@states.length - 1],
                                             unless: @unless_conditions[@states.length - 1],
                                             type: token_type
                                           }
      @if_conditions[@states.length - 1] = nil
      @unless_conditions[@states.length - 1] = nil
      @states.pop 1
    end

    # Transforms all of the arrays to a single matrix
    def to_matrix
      size = [@states.max_by { |tuple| tuple.first }.first, @states.max_by { |tuple| tuple[1] }[1]].max
      @matrix = Matrix.build(size+1, size+1) do |row, col|
        tuple_index = @states.index([row, col])
        unless tuple_index.nil?
            { if: @if_conditions[tuple_index], unless: @unless_conditions[tuple_index] }
        else
          nil
        end
      end

      # Removes now-useless instance variables
      remove_instance_variable :@states
      remove_instance_variable :@if_conditions
      remove_instance_variable :@unless_conditions
      self
    end

    # Generates a lexer based on the state machine
    # Receives the traget language via an argument
    # Currently only supports ruby
    # @example
    # state_machine.generate_lexer :ruby
    def generate_lexer(language)
      case language
      when :ruby
        Generator.ruby(self)
      end
    end

  end
end
