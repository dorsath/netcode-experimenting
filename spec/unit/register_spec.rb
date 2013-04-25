require_relative '../../lib/register'

describe Register do
  let(:info) { double("info").stub(:position) }
  subject { Register.new(info, :position) }

  it "contains information on the object and the method" do
    subject.object.should eql(info)
    subject.method.should eql(:position)
  end

  it "has a priority level of 0 per default" do
    subject.priority.should eql(0)
  end
end
