require 'spec_helper'
 
describe "PasswordResets" do

  before(:each) { visit password_reset_url }

  it "should notify a user when email is sent" do
    user = FactoryGirl.create(:user)
    visit password_reset_url
    fill_in "Email", :with => user.email
    click_button "Reset Password"
    page.should have_content('sent an email')
  end

  it "should notify user if email is not valid" do
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => "foo@bar.co"
    click_button "Reset Password"
    page.should have_content('not valid')
  end

end
    