class LoggerController < ApplicationController
  require 'OAuth'
  require 'json'

  sc_consumer = Soundcloud.consumer('YOUR_CONSUMER_KEY','YOUR_CONSUMER_SECRET')
  
  def redirect 
    @authorize_url = "http://soundcloud.com/oauth/authorize?oauth_token=#{session[:sc_request_token]}"
    redirect_to @authorize_url
  end

  def create_session 
    sc_request_token = sc_consumer.get_request_token(:oauth_callback => url_for(:action => :callback))
    session[:sc_request_token] = sc_request_token.token
    session[:sc_request_token_secret] = sc_request_token.secret  
  end  

  def login
    access_token = OAuth::AccessToken.new(sc_consumer,session[:sc_request_token], session[:sc_request_token_secret])  
    sc_client = Soundcloud.register({:access_token => access_token})
    sc = Soundcloud.register({:access_token => sc_access_token})
    me = sc.User.find_me

    user = User.find_by_sc_user_id(me.id)
    if user.nil?
      user = User.create({:sc_user_id => me.id, :sc_username => me.username,
      :access_token => sc_access_token.token, :access_token_secret => sc_access_token.secret })
    else
      user.sc_username = me.username
      user.access_token = sc_access_token.token
      user.access_token_secret = sc_access_token.secret
      user.save!
    end
    session[:user_id] = user.id
    redirect_to :controller => :home
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You've logged out. Good bye!"    
    redirect_to :controller => :home      
  end
end
