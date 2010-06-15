
describe LoggerController do

  before(:each) do
  
  end
 
  it "should create sc_consumer consumer" do
    logger = logger_controller.new()
    sc_consumer.should_not be_a nil
  end

  it "should create a new session" do
    session[:sc_request_token].should_not be_a nil
    session[sc_request_token_secret].should_not be_a nil
  end
  
  it "should redirect on right site" do
    @authorize_url.should include "http://soundcloud.com/oauth/authorize"
    redirect?.should be_success
  end
  
  it "should next login and create new  user" do
    user.should be_an_instance_of(User)
    session[:user_id].should == user.id
    redirect?.should be_success
  end
  it "should empty session and redirect on home" do
    session[:user_id].should be_a nil
    redirect.should be_success
  end
end
