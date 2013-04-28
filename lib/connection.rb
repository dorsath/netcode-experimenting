class Connection #< EventMachine::Connection
  def initialize(address = nil)
    raise Connection::NoIpAddressGivenError if address.nil?
  end
end
