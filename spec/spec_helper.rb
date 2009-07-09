dir = File.dirname(__FILE__)

$:.unshift(File.join(dir, '/../lib/'))
require dir + '/../lib/twitter_getter'


def unauthenticate_twitter
  TwitterGetter::Base.new
end

def authenticated_twitter
  auth = YAML.load(File.open(File.dirname(__FILE__) + '/test_account.yaml'))
  TwitterGetter::Base.new(auth['user'], auth['password'])
end
