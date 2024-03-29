require 'spec_helper'

describe Ruser::UsersController do
  let(:user) { FactoryGirl.create :user }

  describe ":index" do
    it "should have an index action" do
      get :index,:use_route=>"ruser"
      response.should be_success
    end
  end

  describe ":show" do
    it "should show user" do
      get :show, :id => user.login,:use_route=>"ruser"
      response.should be_success
    end

    it "should render 404 if user not found" do
      get :show, :id => "chunk_norris",:use_route=>"ruser"
      response.should_not be_success
      response.status.should == 404
    end
  end

  describe ":topics" do
    it "should show user topics" do
      get :topics, :id => user.login,:use_route=>"ruser"
      response.should be_success
    end

    it "should render 404 if user not found" do
      get :topics, :id => "chunk_norris",:use_route=>"ruser"
      response.should_not be_success
      response.status.should == 404
    end
  end

  describe ":likes" do
    it "should show user liked stuffs" do
      get :likes, :id => user.login,:use_route=>"ruser"
      response.should be_success
    end

    it "should render 404 if user not found" do
      get :likes, :id => "chunk_norris",:use_route=>"ruser"
      response.should_not be_success
      response.status.should == 404
    end
  end

  describe ":location" do
    it "should render 404 if there is no user in that location" do
      get :location, :id => "Mars",:use_route=>"ruser"
      response.should_not be_success
      response.status.should == 404
    end

    it "should show user associated with that location" do
      get :location, :id => user.location,:use_route=>"ruser"
      response.status.should == 200
      assigns[:users].should include(user)
    end
  end
end
