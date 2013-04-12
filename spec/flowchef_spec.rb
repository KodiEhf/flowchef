require "flowchef"

describe Flowchef::NotifyInbox do
  it "should create a new flowchef notifier for a single token" do
    lambda {
      Flowchef::NotifyInbox.new(:api_token => "test")
    }.should_not raise_error
  end

  it "should create a new flowchef notifier for an array of tokens" do
    lambda {
      Flowchef::NotifyInbox.new(:api_token => ["test", "test"])
    }.should_not raise_error
  end

  it "should set tags" do
    lambda {
      Flowchef::NotifyInbox.new(:api_token => "test",
                                :tags => ["tag1","tag2"])
    }.should_not raise_error
  end

  it "should fail (tags can only be strings)" do
    lambda {
      Flowchef::NotifyInbox.new(:api_token => "test",
                                :tags => ["tag1", Array])
    }.should raise_error(Flowchef::NotifyInbox::InvalidParameterError)
  end

end
