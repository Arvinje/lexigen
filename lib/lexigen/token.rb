module Lexigen
  class Token
    attr_accessor :word, :row, :col, :type, :block_order, :block_number

    def initialize
      @word = ""
    end
  end
end
