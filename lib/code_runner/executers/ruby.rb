module CodeRunner
  module Executers
    class Ruby

      def execute  code
        result = begin
                   `ruby -e '#{code}' 2>&1`
                 rescue => exc
                   exc.message
                 end
        {'success' => true, 'errors' => [], 'output' => result}
      end
    end
  end
end
