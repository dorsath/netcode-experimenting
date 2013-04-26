require_relative 'lib/netcode'
require_relative 'lib/register'

netcode = Netcode.new
class Person
  attr_accessor :position, :direction

  def initialize
    @position = [1,1]
    @direction = [1,1,1]
  end

  def position
    @position[0] += 1
    @position
  end
end

netcode.update_frequency = [1000, 500, 250]
person1 = Person.new
register1 = Register.new(person1, :position)
register2 = Register.new(person1, :direction)


netcode.add_register(register1, 1)
netcode.add_register(register2, 2)

loop do
  netcode.start
end
