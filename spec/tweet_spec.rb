require File.dirname(__FILE__) + '/spec_helper.rb'

describe TwitterGetter::Tweet, "behaviour" do
  
  
  before :all do
    @t = TwitterGetter::Tweet.new(:itsa => "hash", :andalso => {:complex=>true}, 'andevenallows' => 'string keys')
  end
  
  it "should instantiate with a hash and be accessible" do
    @t.andalso.complex.should == true
    @t.andalso[:complex].should == true
    @t[:itsa].should == 'hash'
    @t['itsa'].should == 'hash'
    @t.itsa.should == 'hash'
    @t.size.should == 3
  end
  
  it "should force instantiation with a hash" do
    lambda {TwitterGetter::Tweet.new()}.should raise_error(ArgumentError)
  end
  
  it "should raise nil on an unknown method call" do
    @t.wtf.should == nil
  end
  
  
end


describe TwitterGetter, "example of what to expect in the return from twitter" do
  
  before :all do
    @tg = authenticated_twitter
    @status_update =  @tg.search('twitter').first
  end
  
  it "from a status update" do
    @status_update.from_user.should be_an_instance_of(String)
  end
  
  it "from a user follow" do
    user = @tg.follow(@status_update.from_user)
    user.screen_name.should == @status_update.from_user
    user.friends_count.should >= 0
  end
  
end