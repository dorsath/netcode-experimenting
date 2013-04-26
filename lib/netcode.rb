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

    total = sorted.last

    sorted.each do |base|
      ((total[1] / base[1]).floor).times do |r|
        queue << [base[0], r * base[1]]
      end
    end

    sort_on_time = queue.sort_by { |d| d[1] }
    x = 1
    sort_on_time.map do |prio, time|
      if sort_on_time.count > x
        time_till_next_item_in_queue = sort_on_time[x][1] - time
      else
        time_till_next_item_in_queue = total[1] - time
      end
      x += 1
      [prio, time_till_next_item_in_queue]
    end
  end
end
