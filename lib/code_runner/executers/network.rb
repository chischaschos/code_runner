require 'typhoeus'

module CodeRunner
  module Executers

    class Network
      def execute type, code
        request = Typhoeus::Request.new(
          apis[type],
          method: :get,
          body: code
        )
        request.run
        response = request.response
        response.body
      end

      def supports? type
        apis.has_key?(type)
      end

      def apis
        @apis ||= {
          ruby: 'http://localhost:1111',
          python: 'http://localhost:2222',
        }
      end

    end
  end
end
