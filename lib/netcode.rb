class Netcode
  attr_accessor :connection, :registers

  def initialize
    #setup_connection
    #start_feed_loop
    self.registers = []
  end

  def connected?
    !connection.nil?
  end

  def fetch_info
    registers.map(&:fetch)
  end
end
