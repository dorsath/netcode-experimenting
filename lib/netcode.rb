class Netcode
  attr_accessor :connection, :registers

  def initialize
    #setup_connection
    #start_feed_loop
    self.registers = [[], [], []]
  end

  def add_register(register, prio = 0)
    raise Netcode::RegisterPriorityToHighError if prio > 2
    self.registers[prio] << register
  end

  def priority(prio_level)
    registers[prio_level]
  end

  def connected?
    !connection.nil?
  end

  def fetch_info(prio = 0)
    priority(prio).map(&:fetch)
  end
end
