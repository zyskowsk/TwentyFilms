require 'spec_helper'

describe User do

  it "should be assigned a password_reset_token on creation" do
    user = FactoryGirl.create(:user)
    user.password_reset_token.should_not be_nil
  end

  describe "send_password_reset" do

    it "should generate a unique password reset token" do
      user = FactoryGirl.create(:user)
      current_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(current_token)
    end

    it "should send the user an email" do
      user = FactoryGirl.create(:user)
      user.send_password_reset
      last_email.to.should include(user.email)
    end
  end
end
