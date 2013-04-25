class Netcode
  attr_accessor :connection

  def initialize
    #setup_connection
    #start_feed_loop
  end

  def connected?
    !connection.nil?
  end
end
