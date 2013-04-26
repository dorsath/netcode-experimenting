class Netcode
  attr_accessor :connection, :registers, :update_frequency

  def initialize
    #setup_connection
    #start_feed_loop
    self.registers = [[], [], []]
    self.update_frequency = [500, 100, 10]
  end

  def add_register(register, prio = 0)
    raise Netcode::RegisterPriorityTooHighError if prio > 2
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

  def start
  end

  def build_queue
    queue = []
    frequencies = {}

    update_frequency.each_with_index { |freq, index| frequencies[index] = freq }
    sorted = frequencies.sort_by { |d| d[1] }

    base  = sorted.shift
    total = sorted.pop

    1.upto((total[1] / base[1]).floor) do |r|
      queue << base[0]
      sorted.each do |frequency|
        occurance = queue.select { |d| d == frequency[0] }.count
        if ((r * base[1]) /  frequency[1]) > occurance
          queue << frequency[0]
        end
      end
    end

    queue << total[0]

    queue
  end
end
