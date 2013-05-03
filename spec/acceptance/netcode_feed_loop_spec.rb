require_relative "../support/env"

require_relative "../../lib/netcode"
require_relative "../../lib/connection"
require_relative "../../lib/register"

describe Netcode do

  let(:object){ double("object") }
  let(:register) { Register.new(object, :method) }

  before do
    object.stub(:method) { "Hello world" }
    subject.add_register(register, 0)
    subject.connect(localhost)
  end

  it "sends the data from the object thats registered to Connection's :send_data" do
    queue = [[0,0]]
    subject.connection.should_receive(:send_data).with(["Hello world"])
    subject.run_queue(queue)
  end

  context ".server activated" do
    it "sends the data from the object to the server via connection" do
      server = TestServer.new

      queue = [[0,0]]
      subject.run_queue(queue)
      sleep(0.1)
      server.response.should == ["Hello world"]
    end

  end

end
