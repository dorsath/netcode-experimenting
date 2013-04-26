require_relative "../../lib/netcode"

describe Netcode do
  let(:connection) { double("connection") }

  context ".connection" do
    it "accepts a connection" do
      subject.connection = connection
      subject.should be_connected
    end
  end

  context ".frequencies & queues" do
    it "has an update frequency for all the 3 prio's per default" do
      subject.update_frequency.should == [500, 100, 10]
    end

    it "builds a queue based on the frequencies" do
      subject.update_frequency = [10, 5, 1]
      subject.build_queue.should == [2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 0]
    end
  end

  context ".feed_loop" do
    it "calls each priority on its own frequency" do
      #times = []
      #t0 = Time.now.to_f
      #subject.start
      #subject.stub(:fetch_info) { times << (t0 - Time.now.to_f) }
      #p times
    end
  end
end

