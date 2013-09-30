require 'eventmachine'
require_relative '../executers/ruby'

module CodeRunner
  module Servers
    class Ruby < EM::P::HeaderAndContentProtocol
      def receive_request headers, content
        puts "Code: #{content}"

        result = Executers::RubyServer.execute content

        puts "Result: #{result}"
        send_data result
        close_connection_after_writing
      end
    end
  end
end

EventMachine.run {
  Signal.trap("INT")  { EventMachine.stop }
  Signal.trap("TERM") { EventMachine.stop }
  EventMachine.start_server '0.0.0.0', 1111, CodeRunner::Servers::Ruby
}
