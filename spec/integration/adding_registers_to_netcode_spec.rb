describe Netcode do
  let(:method)   { :position }
  let(:object)     { double("info") }
  let(:register) { Register.new(object, method)  }

  before do
    object.stub(method) { "welkom123" }
  end

  it "allows adding registers to a netcode" do
    subject.registers << register
    subject.registers.count.should == 1
  end

  context ".send_thru" do
    before do
      subject.registers << register
    end

    it "fetches the registers information to be send through" do
      subject.fetch_info.should include(object.send(method))
    end
  end
end
