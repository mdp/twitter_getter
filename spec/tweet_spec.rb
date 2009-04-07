require File.dirname(__FILE__) + '/spec_helper.rb'

describe Tweet, "behaviour" do
  
  
  before :all do
    @t = Tweet.new(:itsa => "hash", :andalso => {:complex=>true}, 'andevenallows' => 'string keys')
  end
  
  it "should instantiate with a hash and be accessible" do
    @t.andalso.should == {:complex => true}
    @t[:itsa].should == 'hash'
    @t['itsa'].should == 'hash'
    @t.itsa.should == 'hash'
    @t.size.should == 3
  end
  
  it "should force instantiation with a hash" do
    lambda {Tweet.new()}.should raise_error(ArgumentError)
  end
  
  it "should raise NoMethod on a bad call" do
    lambda {@t.wtf}.should raise_error(NoMethodError)
  end
  
  
end