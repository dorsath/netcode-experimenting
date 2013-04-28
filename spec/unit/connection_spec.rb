require_relative '../../lib/connection'

describe Connection do
  it "raises an error when given no ip address" do
    expect { Connection.new}.to raise_exception
  end
end
