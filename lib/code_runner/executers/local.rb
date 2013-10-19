require 'typhoeus'

module CodeRunner
  module Executers

    class Local
      def execute type, code
        executer = executer_class(type).new
        executer.execute code
      end

      def supports? type
        CodeRunner::Executers.const_defined? type.capitalize
      end

      def executer_class type
        CodeRunner::Executers.const_get type.capitalize
      end
    end
  end
end
