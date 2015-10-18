module Lexigen
  class Generator

    # Creates a new RubyGenerator and generate a lexer
    # based on the given state machine
    def self.ruby(state_machine)
      rb_generator = RubyGenerator.new(state_machine)
      rb_generator.generate
    end

  end
end
