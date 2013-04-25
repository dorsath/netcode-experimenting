class Register
  attr_accessor :object, :method, :priority

  def initialize(object, method)
    self.object, self.method, self.priority = object, method, 0
  end

  def fetch
    object.send(method)
  end
end
