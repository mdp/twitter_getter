require File.dirname(__FILE__) + '/spec_helper.rb'

describe TwitterGetter do
  
  
  before :all do
    @tg = TwitterGetter.new
  end
  
  it "should find all location based tweets" do
    t = @tg.search('twitter', :geocode => '33.75916942652898,-84.38941955566406,100mi')
    t.size.should eql(50)
    t[0].from_user.size.should >= 1
  end
  
  it "should allow search multiple pages" do
    t = @tg.search('twitter', :geocode => '33.75916942652898,-84.38941955566406,100mi', :max_pages => 2)
    t.size.should eql(100)
  end
  
  
end