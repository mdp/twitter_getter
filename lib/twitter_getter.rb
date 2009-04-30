require 'rubygems'
require 'cgi'
require 'rest_client'
require 'json/pure'
require 'twitter_getter/promiscuous_struct'

module TwitterGetter

  class Tweet
    include PromiscuousStruct
  end

  class User
    include PromiscuousStruct
  end

  class Base

    attr_accessor :user, :password

    def initialize(user=nil, password=nil)
      @user = user
      @password = password
    end
    
    def update_status(message, in_reply_to_status_id = nil)
      raise AuthenicationNeeded if @password.nil?
      t = JSON.parse(RestClient.post("http://#{@user}:#{@password}@twitter.com/statuses/update.json", 
                 :status => message,
                 :in_reply_to_status_id => in_reply_to_status_id))
      Tweet.new(t)
    end
    
    def destroy_status(id)
      raise AuthenicationNeeded if @password.nil?
      t = JSON.parse(RestClient.post("http://#{@user}:#{@password}@twitter.com/statuses/destroy/#{id}.json", :id => id))
      Tweet.new(t)
    end
    
    def status(id)
      t = JSON.parse(RestClient.get("http://twitter.com/statuses/show/#{id}.json"))
      Tweet.new(t)
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
        u['status'] ? User.new(u) : nil
      rescue RestClient::RequestFailed => e
        p e
        nil
      end
    end

    def follow(id)
      raise AuthenicationNeeded if @password.nil?
      begin
        u = JSON.parse(RestClient.post("http://#{@user}:#{@password}@twitter.com/friendships/create/#{id}.json", :id => id))
        u['status'] ? User.new(u) : nil
      rescue RestClient::RequestFailed => e
        p e
        nil
      end
    end

    def rate_limit_status
      results = JSON.parse(RestClient.get("http://#{@user}:#{@password}@twitter.com/account/rate_limit_status.json"))
    end

    def search(term, opts = {})
      if opts[:max_pages]
        max_pages = opts[:max_pages]
        opts.delete(:max_pages)
      end
      term = CGI.escape(term)
      opts = {
        :since_id => 10,
        :rpp => 50
      }.merge(opts)
      params = hash2params(opts)
      tweets = []
      JSON.parse(RestClient.get("http://search.twitter.com/search.json?q=#{term}#{params}"))['results'].each do |t|
        tweets << Tweet.new(t)
      end
      results = tweets.size
      page = 2
      while results == 50 && page <= max_pages.to_i
        next_tweets = JSON.parse(RestClient.get("http://search.twitter.com/search.json?q=#{term}#{params}&page=#{page}"))['results']
        results = next_tweets.size
        next_tweets.each do |t|
          tweets << Tweet.new(t)
        end
        page += 1
      end
      tweets.reverse
    end

    private

    def hash2params(hash)
      params = ''
      hash.each_pair do |k,v|
        params += "&#{k}=#{CGI.escape(v.to_s)}"
      end
      params
    end


  end
end
