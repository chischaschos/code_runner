require 'eventmachine'

module CodeRunner
  class RubyServer < EM::P::HeaderAndContentProtocol
    def receive_request headers, content
      code = content[5..-1]
      puts "Code: #{code}"
      result = begin
                 `ruby -e "#{code}" 2>&1`
               rescue => exc
                 exc.message
               end
      puts "Result: #{result}"
      send_data "Result: #{result}"
      close_connection_after_writing
    end
  end
end

EventMachine.run {
  Signal.trap("INT")  { EventMachine.stop }
  Signal.trap("TERM") { EventMachine.stop }
  EventMachine.start_server '0.0.0.0', 1111, CodeRunner::RubyServer
}
