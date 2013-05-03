require 'socket'
class Connection #< EventMachine::Connection
  attr_accessor :address, :port

  def initialize(address = nil, port = 4481)
    raise Connection::NoIpAddressGivenError if address.nil?
    self.address = address
    self.port    = port
  end

  def send_data(data)
    begin
      loop do
        bytes = client.write_nonblock(payload)

        break if bytes >= payload.to_s.size
        payload.slice!(0, bytes)
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
