class Connection #< EventMachine::Connection
  def initialize(address = nil)
    raise Connection::NoIpAddressGivenError if address.nil?
  end

  def send_data(data)
    
  end
end
