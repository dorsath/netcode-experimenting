require_relative '../../lib/register'

describe Register do
  let(:object) { double("info") }
  subject { Register.new(object, :position) }

  before do
    object.stub(:position) { "welkom123" }
  end

  it "contains information on the object and the method" do
    subject.object.should eql(object)
    subject.method.should eql(:position)
  end

  it "fetches the info" do
    subject.fetch.should == "welkom123"
  end


  context ".priority" do
    it "has a priority level of 0 per default" do
      subject.priority.should eql(0)
    end

    it "can have a different priority" do
      a = Register.new(object, :hello, 1)
      a.priority.should eql(1)
    end
  end
end
