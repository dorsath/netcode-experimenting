require_relative "../../lib/netcode"

describe Netcode do
  let(:connection) { double("connection") }

  context ".connection" do
    it "accepts a connection" do
      subject.connection = connection
      subject.should be_connected
    end
  end
end

