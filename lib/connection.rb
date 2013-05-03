require 'json'
require 'socket'

class Connection #< EventMachine::Connection
  attr_accessor :address, :port

  def initialize(address = nil, port = 4481)
    raise Connection::NoIpAddressGivenError if address.nil?
    self.address = address
    self.port    = port
  end

  def send_data(complex_data)
    data = complex_data.to_json
    begin
      loop do
        bytes = client.write_nonblock(data)

        break if bytes >= data.size
        data.slice!(0, bytes)
        print "sending more\n"
        IO.select(nil, [client])
      end

    rescue Errno::EAGAIN
      IO.select(nil, [client])
      retry
    end
  end

  def client
    @client ||= connect
  end

  def connect
    TCPSocket.new(address, port)
  end
end
