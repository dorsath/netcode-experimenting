describe Netcode do
  it "creates a new connection on connect" do
    subject.connect("127.0.0.1")
    subject.connection.should be_a(Connection)
  end

  it "raises error when starting without connection" do
    subject.connection = nil
    expect { subject.start! }.to raise_exception
  end
end
