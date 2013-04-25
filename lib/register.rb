class Register
  attr_accessor :object, :method, :priority

  def initialize(object, method, priority = 0)
    self.object, self.method, self.priority = object, method, priority
  end

  def fetch
    object.send(method)
  end
end
