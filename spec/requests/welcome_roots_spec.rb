require 'spec_helper'

describe "WelcomeRoots" do
  it "redirects to password reset page when user clicks forgot password link" do
    user = FactoryGirl.build(:user)
    visit root_url
    click_link "password"
    current_path.should == "/password_reset"
  end
end
