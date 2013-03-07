require 'rubygems'
require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require './spec_helper.rb'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://tuftsdev.github.com'

describe "testing" do
  it "displays something" do
    visit "/"
    page.should have_content "something"
  end
end
