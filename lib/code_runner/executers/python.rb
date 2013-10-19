require 'json'

module CodeRunner
  module Executers
    class Python

      def execute  code
        JSON.parse `bin/sandboxed.py '#{code}'`
      end
    end
  end
end
