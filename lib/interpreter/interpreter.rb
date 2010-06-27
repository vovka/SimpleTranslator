module Translator
  module Interpreter
    include Translator::Interpreter::Instructions
    
    INSTRUCTIONS_FOLDER_NAME = "./instructions"

    def interpret string
      load_instructions! if !instructions_loaded?
      if !instructions_loaded?
        p "Instructions have not loaded"
        return
      end
      instruction, parameters = find_instruction string
      execute(instruction, parameters) if !instruction.nil?
    end

    def find_instruction string
      clear_instruction = clean_instruction_of_husks string
      
      instruction = @instructions.select { |pattern, instruction_proc| clear_instruction =~ pattern }
      
      if instruction.empty?
        puts <<EOS
\n\e[1;33;40mYou should define step like this:
Given /^#{clear_instruction}$/ do
  #pending
end\e[0m
EOS
        return
      end
      
      (text_parameters = clear_instruction.match(instruction[0][0]).to_a).shift
      instruction_proc = instruction[0][1]
      [instruction_proc, text_parameters]
    end

    def execute instruction, parameters
      instruction.call *parameters
    end

    def conditional_words_pattern
      @conditional_words_pattern ||= Regexp.new "^(#{CONDITIONAL_WORDS.join('|')}) (.*)"
    end

    def clean_instruction_of_husks string
      string = string.strip.match(conditional_words_pattern)
      !string.nil? and string.is_a?(MatchData) ? string[2] : nil
    end
    
    def load_instructions!
      dir = INSTRUCTIONS_FOLDER_NAME
      (Dir.new(dir).entries - ['.', '..']).each{|file| eval read_file(File.join dir, file) }
    end
    
    def instructions_loaded?
      !@instructions.nil? and !@instructions.empty?
    end
  end
end
