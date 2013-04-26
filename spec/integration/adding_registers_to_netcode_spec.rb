describe Netcode do
  let(:method)   { :position }
  let(:object)     { double("info") }
  let(:register) { Register.new(object, method)  }

  before do
    object.stub(method) { "welkom123" }
  end

  it "allows adding registers to a netcode" do
    subject.add_register(register)
    subject.priority(0).count.should == 1
  end

  context ".send_thru" do
    before do
      subject.add_register(register)
    end

    it "fetches the registers information to be send through" do
      subject.fetch_info.should include(object.send(method))
    end

    context ".priority" do
      let(:high_prio_object)  { double("high_prio") }

      let(:high_prio_register){ Register.new(high_prio_object, :position, 2) }

      before do
        high_prio_object.stub(:position) { "high prio info" }
      end

      it "only fetches of the priority asked" do
        subject.add_register(high_prio_register, 2)

        subject.fetch_info(2).should == ["high prio info"]
      end
    end
  end
end
