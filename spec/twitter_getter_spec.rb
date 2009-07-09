require File.dirname(__FILE__) + '/spec_helper.rb'
require 'yaml'

describe TwitterGetter, "GeoIP search" do
  
  
  before :all do
    @tg = unauthenticate_twitter
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

describe TwitterGetter, "sends a tweet, find it, and destroy it" do
  
  before :all do
    @tg = authenticated_twitter
    tweets = @tg.search('twitter')
    t = tweets.first
    @test_message = "RT @#{t.from_user} #{t.text[0, t.from_user.size + 5]}"
    @test_update = @tg.update_status(@test_message)
  end
  
  it "should be able to send and then find a status update for the authenticated user" do
    @test_update.text.should eql(@test_message)
  end
  
  it "should be able to find the test tweet" do
    @tg.status(@test_update.id).text.should eql(@test_message)
  end
  
  it "should also be able to destroy it" do
    @tg.destroy_status(@test_update.id).text.should eql(@test_message)
    # Verify it's destroyed
    lambda {@tg.status(@test_update.id)}.should raise_error(RestClient::Exception)
  end
  
end