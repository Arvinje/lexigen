require_relative "lib/lexigen/token"

module Lexigen
  class Lexer

    def initialize
      @row = 0
      @column = 0
      @state = 0
      @position = 0
    end

    # Returns next token as an instance of Lexigen::Token
    # The currently implemented state machine detects integer,
    # float and identification.
    def next
      File.open("lib/lexigen/test.txt", 'r') do |f|
        f.seek(@position, IO::SEEK_SET)
        while char = f.getc

          if char == "\n"
            @row += 1
            @column = 0
          else
            @column += 1
          end

          case @state
          when 0    # Starting state

            @token = Lexigen::Token.new
            @token.column = @column
            @token.row = @row

            case char
            when /\d/   # When digit
              @token.word << char
              @state = 1
            when /\s/   # When space
              @state = 0
            when /\w/   # When letter
              @token.word << char
              @state = 3
            else        # Everything else
              @position = f.pos - 1
              return "error"
            end
          when 1    # Integer
            case char
            when /\d/   # When digit
              @token.word << char
              @state = 1
            when /\./   # When decimal point
              @token.word << char
              @state = 2
            else        # Return integer
              @state = 0
              @token.type = :int
              @position = f.pos - 1
              return @token
            end
          when 2    # Float
            case char
            when /\d/   # When digit
              @token.word << char
              @state = 2
            else        # Return float
              @state = 0
              @token.type = :float
              @position = f.pos - 1
              return @token
            end
          when 3    # Identification
            case char
            when /\w|\d|_/    # When letter, digit or underscore
              @token.word << char
              @state = 3
            else    # Return identification
              @state = 0
              @token.type = :id
              @position = f.pos - 1
              return @token
            end
          end
        end

      end
    end

  end
end
