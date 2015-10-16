module Lexigen
  class Token
    attr_accessor :word, :row, :column, :type, :block_order, :block_number

    def initialize
      @word = ""
    end
  end
end
