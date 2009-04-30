require File.dirname(__FILE__) + '/spec_helper.rb'

describe TwitterGetter, "behaviour" do
  
  it "should destroy an existing status" do
     auth = YAML.load(File.open(File.dirname(__FILE__) + '/test_account.yaml'))
     tg = TwitterGetter::Base.new(auth['user'], auth['password'])
     p tg.destroy_status(1650005187)
  end
  
end
