#encoding: utf-8
require 'spec_helper'

describe "sign up and login" do

  it "let user sign up and login to the site" do
    visit '/ruser/account/sign_in'
   
    click_link '注册'

   #  page.must_have_content('注册新用户')
    #   save_and_open_page
    fill_in 'user_login', :with => 'rubyist8'
  #   save_and_open_page
    fill_in 'user_email', :with => 'rubyist@ruby-china.org'
    fill_in 'user_password', :with => 'coolguy'
    fill_in 'user_password_confirmation', :with => 'coolguy'
    click_button '提交注册信息'
    page.should have_content('活跃帖子')
    within("#userbar") do
      click_on 'rubyist'
    end

    click_link '退出'
    page.should have_content('退出成功.')

    click_link '登录'
    fill_in '用户名', :with => 'rubyist'
    fill_in '密码', :with => 'coolguy'
    click_button '登录'
    page.should have_content('活跃帖子')
  end

  it "fail to sign up new user if password field is protected" do
    Ruser::User.class_eval do
      attr_protected :password
    end

    visit '/ruser'
    click_link '注册'
    fill_in '用户名', :with => 'rubyist'
    fill_in 'Email', :with => 'rubyist@ruby-china.org'
    fill_in '密码', :with => 'coolguy'
    fill_in '确认密码', :with => 'coolguy'
    click_button '提交注册信息'
    page.should have_content('密码 不能为空字符')
  end
end
