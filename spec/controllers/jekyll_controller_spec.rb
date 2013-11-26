require 'spec_helper'

describe JekyllController do
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'create'" do

    it "should be successful" do
      get :create
      response.should be_success
    end
  end

end
