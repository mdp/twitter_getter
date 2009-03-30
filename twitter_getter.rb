require 'rubygems'
require 'cgi'
require 'rest_client'
require 'json/pure'

class Tweet

  attr_reader :attributes
  
  def initialize(h)
    @attributes = h
  end
  
  def get_val(a)
    @attributes[a] || @attributes[a.to_s]
  end
  
  def [](a)
   get_val(a)
  end
  
  def method_missing(m)
    val = get_val(m)
    super if val.nil? 
    val
  end

end

class Tweets
  
  def initialize(h)
    
  end
  
end

class TwitterGetter

  attr_accessor :user, :password

  def initialize(user=nil, password=nil)
    @user = user
    @password = password
  end

  def friend_ids
    JSON.parse(RestClient.get("http://twitter.com/friends/ids/#{self.user}.json"))
  end
  
  def follower_ids
    JSON.parse(RestClient.get("http://twitter.com/followers/ids/#{self.user}.json"))
  end

  def unfriendly_ids
    self.friend_ids - self.follower_ids
  end

  def unfollow(id)
    raise AuthenicationNeeded if @password.nil?
    begin
      u = JSON.parse(RestClient.post("http://#{@user}:#{@password}@twitter.com/friendships/destroy/#{id}.json", :id => id))
      u['status'] ? u : nil
    rescue RestClient::RequestFailed => e
      p e
      nil
    end
  end
  
  def follow(id)
    raise AuthenicationNeeded if @password.nil?
    begin
      u = JSON.parse(RestClient.post("http://#{@user}:#{@password}@twitter.com/friendships/create/#{id}.json", :id => id))
      u['status'] ? u : nil
    rescue RestClient::RequestFailed => e
      p e
      nil
    end
  end
  
  def rate_limit_status
    results = JSON.parse(RestClient.get("http://#{@user}:#{@password}@twitter.com/account/rate_limit_status.json"))
  end
  
  def search(term, opts = {})
    term = CGI.escape(term)
    opts = {
      :since_id => 10,
      :max_pages => 1
    }.merge(opts)
    p opts[:since_id]
    tweets = JSON.parse(RestClient.get("http://search.twitter.com/search.json?q=#{term}&rpp=50&since_id=#{opts[:since_id]}"))['results']
    results = tweets.size
    page = 2
    while results == 50 && page <= opts[:max_pages].to_i
      next_tweets = JSON.parse(RestClient.get("http://search.twitter.com/search.json?q=#{term}&rpp=50&since_id=#{opts[:since_id]}&page=#{page}"))['results']
      results = next_tweets.size
      tweets += next_tweets
      page += 1
    end
    tweets.reverse
  end

end
