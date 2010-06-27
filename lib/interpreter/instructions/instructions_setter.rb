module Translator
  module Interpreter
    module Instructions
      def set_instruction intruction_pattern, &block
        @instructions = {} if !@instructions
        @instructions[intruction_pattern] = block if block_given?
      end

      CONDITIONAL_WORDS = %w{ Given And Then When }

      CONDITIONAL_WORDS.each { |word| eval "alias #{word} set_instruction" }
    end
  end
end
