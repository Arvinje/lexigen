module Lexigen
  class StateMachine
    attr_reader :matrix

    def initialize
      @states = []
      @if_conditions = []
      @unless_conditions = []
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
    end

    # Respective unless-condition of each transition
    def unless(condition)
      @unless_conditions[@states.length - 1] = condition
    end

    # Transforms all of the arrays to a single matrix
    def to_matrix
      size = [@states.max_by { |tuple| tuple.first }.first, @states.max_by { |tuple| tuple[1] }[1]].max
      @matrix = Matrix.build(size+1, size+1) do |row, col|
        tuple_index = @states.index([row, col])
        unless tuple_index.nil?
          { if: @if_conditions[@states.index([row, col])], unless: @unless_conditions[@states.index([row, col])] }
        else
          nil
        end
      end
      self
    end
    
  end
end
