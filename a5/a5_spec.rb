require 'rubygems'
require 'rspec'
require 'pry'
require 'capybara'
require 'rest-client'
require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara-webkit'
require './spec_helper.rb'

Capybara.run_server = false
Capybara.javascript_driver = :webkit

# Regex searches for this line
@url = 'aqueous-dusk-9652.herokuapp.com'
raise "URL not set" if @url.nil?

Capybara.app_host = @url

describe "Assignment 5 - Scorecenter", js: true do
  def url_from(uri="/")
    # Regex searches for this line
    @url = 'aqueous-dusk-9652.herokuapp.com'
    raise "URL not set" if @url.nil?

    @url + uri
  end

  def post(uri, data=nil, format=:json)
    RestClient.post(url_from(uri), data, content_type: format)
  end

  def get(uri, query="")
    RestClient.get([url_from(uri), query].join("?"))
  end

  def click_search_or_submit_button_or_link
    begin
      click_link_or_button "submit"
    rescue
      begin
        click_link_or_button "Search"
      rescue
        click_link_or_button "Submit"
      end
    end
  end

  describe "GET '/'" do
    it "responds with a success" do
      visit "/"

      page.should_not have_content "Heroku | No such app"
      page.should_not have_content "Heroku | Welcome to your new app!"
      page.should_not have_content "Application Error"
    end
  end

  describe "POST '/submit.json'" do
    context "with valid params" do
      it "displays the highscores on the homepage" do
        post "/submit.json", { username: "Grader comp 1", game_title: "Grading game 1", score: 11111101 }

        visit "/"

        page.should have_content "Grading game 1"
        page.should have_content "Grader comp 1"
        page.should have_content "11111101"
      end

      # take a look who failed
      it "is not dependent on order of json" do
        post "/submit.json", { username: "Grader comp 3", game_title: "Grading game 3", score: 11111103 }

        visit "/"

        page.should have_content "Grading game 3"
        page.should have_content "Grader comp 3"
        page.should have_content "11111103"
      end
    end

    context "with invalid params" do
      it "does not display if 'game_title' is missing" do
        post "/submit.json", { username: "Grader comp 6", score: 11111106 }

        visit "/"

        page.should_not have_content "Grader comp 6"
        page.should_not have_content "11111106"
      end

      it "does not display if 'username' is missing" do
        post "/submit.json", { game_title: "Grading game 7", score: 11111107 }

        visit "/"

        page.should_not have_content "Grading game 7"
        page.should_not have_content "11111107"
      end

      it "does not display if 'score' is missing" do
        post "/submit.json", { game_title: "Grading game 8", username: "Grader comp 8" }

        visit "/"

        page.should_not have_content "Grading game 8"
        page.should_not have_content "Grader comp 8"
      end
    end
  end

  describe "GET '/usersearch'" do
    # take a look who failed
    it "has a input box" do
      visit "/usersearch"

      page.should have_css("#input")
      page.should have_css("#submit")
    end


    context "searching for 'username'" do
      # take a look who failed
      it "displays the users scores" do
        post "/submit.json", { game_title: "Grading game 9", username: "Grader comp 9", score: 11111109 }
        post "/submit.json", { game_title: "Grading game 9", username: "Grader comp 9", score: 11111110 }

        visit "/usersearch"

        fill_in "input", with: "Grader comp 9"
        click_search_or_submit_button_or_link

        page.should have_content "Grading game 9"
        page.should have_content "11111109"
        page.should have_content "11111110"
      end
    end

    context "searching for bad 'username'" do
      it "does not display any results", js: true do
        visit "/usersearch"

        fill_in "input", with: "Some random grader that is not inputed"
        click_search_or_submit_button_or_link

        page.should_not have_content "Grading game 9"
        page.should_not have_content "11111109"
        page.should_not have_content "11111110"
      end
    end
  end

  describe "GET '/highscores.json'" do
    before (:all) do
      15.times do |n|
        post "/submit.json", { game_title: "Grading game 11", username: "Grader comp 11", score: n }
      end
    end

    it "should only return 10 items" do
      response = get "/highscores.json", "game_title=Grading+game+11"

      JSON.parse(response).length.should == 10
    end

    it "displays them in order" do
      response = get "/highscores.json", "game_title=Grading+game+11"

      JSON.parse(response)[0]['score'].to_i.should == 14
      JSON.parse(response)[1]['score'].to_i.should == 13
      JSON.parse(response)[2]['score'].to_i.should == 12
      JSON.parse(response)[3]['score'].to_i.should == 11
      JSON.parse(response)[4]['score'].to_i.should == 10
      JSON.parse(response)[5]['score'].to_i.should == 9
      JSON.parse(response)[6]['score'].to_i.should == 8
      JSON.parse(response)[7]['score'].to_i.should == 7
      JSON.parse(response)[8]['score'].to_i.should == 6
      JSON.parse(response)[9]['score'].to_i.should == 5
    end

    it "has a 'created_at' field" do
      response = get "/highscores.json", "game_title=Grading+game+11"

      JSON.parse(response)[0]['created_at'].should_not be_nil
    end

    it "does not return bad items" do
      response = get "/highscores.json?game_title=no+game+found+here+I+hope"

      JSON.parse(response).length.should == 0
    end
  end
end
