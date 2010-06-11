require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :sc_user_id => 1,
      :sc_username => "value for sc_username",
      :access_token => "value for access_token",
      :access_token_secret => "value for access_token_secret",
      :upload_secret => "value for upload_secret"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
