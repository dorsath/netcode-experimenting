require_relative "../support/env"

require_relative '../../lib/connection'

describe Connection do
  it "raises an error when given no ip address" do
    expect { Connection.new}.to raise_exception
  end

  context ".sending" do
    subject { Connection.new(localhost) }

  end
end
