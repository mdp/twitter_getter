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