describe Netcode do
  let(:info)     { double("info").stub(:position) }
  let(:register) { Register.new(info, :position)  }
  it "allows adding registers to a netcode" do
    subject.registers << register
    subject.registers.count.should == 1
  end
end
