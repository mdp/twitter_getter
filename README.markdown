# TwitterGetter - A simple Twitter API gem

## Installation

    sudo gem install markpercival-twitter_getter --sources http://gems.github.com

## Usage
  
    @tg = TwitterGetter::Base.new('ev', 'password')
    tweets = @tg.search('failwhale')
    tweets.each do |t|
      p "#{t.from_user}: #{t.text}"
    end
    
    @tg.follow('aplusk')

## License

This code is free to use under the terms of the MIT license. 

## Contact

Mark Percival <mark@mpercival.com>

