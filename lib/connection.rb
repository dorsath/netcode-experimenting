class Connection
  def initialize(address = nil)
    raise Connection::NoIpAddressGiven if address.nil?
  end
end
