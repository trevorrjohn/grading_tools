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

describe "testing", js: true do
  @repos = ["comp20-abellinger", "comp20-abrieff", "comp20-acrookes", "comp20-adempsey",
            "comp20-ajarowenko", "comp20-ajenkins", "comp20-ali", "comp20-amendelsohn",
            "comp20-aschaefer", "comp20-ashinn", "comp20-atai", "comp20-awassall",
            "comp20-bcadigan", "comp20-bcefali", "comp20-bconron", "comp20-bdell",
            "comp20-aberman", "comp20-bfischler", "comp20-bleiken", "comp20-bnichols",
            "comp20-bwood", "comp20-cblanck", "comp20-cclairmont", "comp20-cjackson",
            "comp20-cmalchik", "comp20-cmarcks", "comp20-csaund", "comp20-ctaylor",
            "comp20-cvrettos", "comp20-dchen", "comp20-ddupont", "comp20-dgriffin",
            "comp20-dkulla", "comp20-dlyle", "comp20-dminnick", "comp20-drichard",
            "comp20-ediaz", "comp20-edouglas", "comp20-eeng", "comp20-eferber",
            "comp20-emariasis", "comp20-emoore", "comp20-eqstrom", "comp20-evoegeli",
            "comp20-fpittaluga", "comp20-gbambushew", "comp20-gfriedman", "comp20-gjoseph",
            "comp20-gnicholas", "comp20-golsen", "comp20-hiqbal", "comp20-hmansoor",
            "comp20-hmao", "comp20-icross", "comp20-ifried", "comp20-igray",
            "comp20-iredelmeier", "comp20-jaronoff", "comp20-jcanuel", "comp20-jdowner",
            "comp20-jeaton", "comp20-jfishbein", "comp20-jfleming", "comp20-jlemay",
            "comp20-jlipson", "comp20-jlocke", "comp20-jlockwood", "comp20-jmao",
            "comp20-jmarvel", "comp20-sowades", "comp20-jrahamim", "comp20-jschneiderman",
            "comp20-jserrino", "comp20-jwang", "comp20-jwat", "comp20-jwright",
            "comp20-karagam", "comp20-kcohen", "comp20-kford", "comp20-kgerritz",
            "comp20-kgnana", "comp20-kogrady", "comp20-ksegawa", "comp20-kwu",
            "comp20-lades", "comp20-ldahill", "comp20-lrassaby", "comp20-lsuarez",
            "comp20-mbliss", "comp20-mnobel", "comp20-msilverblatt", "comp20-msmiley",
            "comp20-ndavis", "comp20-nkapur", "comp20-nsalk", "comp20-ntarrh",
            "comp20-nteleky", "comp20-nwebster", "comp20-pattra", "comp20-rcarter",
            "comp20-rhong", "comp20-rschlaikjer", "comp20-rbarnes", "comp20-rxiao",
            "comp20-sbrown", "comp20-sclark", "comp20-sdushay", "comp20-sfriedman",
            "comp20-sharrington", "comp20-skrevans", "comp20-slenoach", "comp20-slessard",
            "comp20-smcdaniel", "comp20-smeldrum", "comp20-snevatia", "comp20-spurcell",
            "comp20-sshaidani", "comp20-talander", "comp20-tfolliard", "comp20-tgeheran",
            "comp20-tkola", "comp20-tlubeck", "comp20-uberger", "comp20-vcung",
            "comp20-wparker", "comp20-zsobin"].reverse!

  @repos.each do |repo|
    it "displays something" do
      visit "/#{repo}/where/"

      puts "-"*15 + " Console messages " + "-"*15
      puts page.driver.console_messages.length
      puts "-"*15 + " JS errors messages " + "-"*15
      puts page.driver.error_messages.length
      (1+1).should == 2

    end

    input = nil
    while(input.nil?)
      input = gets
      break if input == "q"
    end
  end
end
