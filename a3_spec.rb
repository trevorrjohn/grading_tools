require 'rubygems'
require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara-webkit'
require './spec_helper.rb'

Capybara.run_server = false
Capybara.current_driver = :webkit
Capybara.app_host = 'http://tuftsdev.github.com'

describe "testing" do
  it "displays something" do
    visit "//where/"

    page.driver.console_messages.length.should == 0
    page.driver.error_messages.length.should == 0

  end
end
