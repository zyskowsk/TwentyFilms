require 'spec_helper'
 
describe "PasswordResets" do
  before(:each) { visit password_reset_url }

  describe "ValidRequest" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      fill_in "Email", :with => user.email 
      click_button "Reset Password"
    end

    it "should notify a user when email is sent" do
      page.should have_content('sent an email')
    end


    it "should send email when user submits email" do
      last_email.to.should include(user.email)
    end

    it "should send email with new token in html version" do
      last_email.html_part.body.raw_source.should include('Password Reset Token')
    end

    it "should send email with new token in text version" do
      last_email.text_part.body.raw_source.should include('Password Reset Token')
    end
  end

  describe "InValidRequest" do 
    before(:each) do
      fill_in "Email", :with => "bar@foo.com" 
      click_button "Reset Password"
    end

    it "should notify user if email is not valid" do
      page.should have_content('not valid')
    end

    it "should not send email when user submits invalid email" do
      last_email.should be_nil
    end
  end
end
    