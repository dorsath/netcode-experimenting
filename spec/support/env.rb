def localhost
  "127.0.0.1"
end

require 'socket'
require 'json'

class TestServer
  attr_accessor :response

  def initialize(port = 4481)
    Thread.new do
      socket = Socket.tcp_server_loop(port) do |connection|
        begin
          self.response = connection.read_nonblock(4096)
        rescue IO::WaitReadable
          IO.select([connection])
          retry
        end
        connection.close
      end
    end
    sleep(0.1)
  end

  def response=(response_in_json)
    @response = JSON.parse(response_in_json)
  end
end
