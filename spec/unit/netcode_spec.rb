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
      subject.build_queue.should == [[2, 0], [1, 0], [0, 1], [2, 1], [2, 1], [2, 1], [2, 1], [1, 0], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1]]
    end
  end

  context ".feed_loop" do
    before do
      subject.connect("127.0.0.1")
    end

    it "runs a queue of times and priorities" do
      queue = [[0,1],[1,1],[2,1]]
      subject.should_receive(:fetch_info).exactly(3)
      subject.run_queue(queue)
    end

    it "calls each priority on its own frequency" do
      times = []
      queue = subject.build_queue

      t0 = Time.now.to_f
      subject.stub(:fetch_info) { times << ((Time.now.to_f - t0) * 1000) }

      subject.run_queue(queue)

      queue.unshift([0, 0])
      times.each_with_index do |time, index|
        dt = (index == 0 ? time : time - times[index - 1])
        (dt - queue[index][1]).abs.should < 3
      end
    end
  end
end

