#!/usr/bin/ruby

repos = %w(comp20-wparker comp20-vcung comp20-tkola comp20-tfolliard comp20-talander comp20-sshaidani comp20-snevatia comp20-skrevans comp20-sfriedman comp20-rxiao comp20-rbarnes comp20-rhong comp20-rcarter comp20-pattra comp20-nwebster comp20-nsalk comp20-msmiley comp20-mnobel comp20-lsuarez comp20-kgnana comp20-jwat comp20-jwang comp20-jmarvel comp20-jlemay comp20-jfleming comp20-jdowner comp20-jaronoff comp20-iredelmeier comp20-hmansoor comp20-eqstrom comp20-ediaz comp20-cclairmont comp20-bwood comp20-aberman comp20-bdell comp20-ajarowenko comp20-abrieff comp20-abellinger)
errs = []
username = "tuftsdev"
branch = "gh-pages"
dir = Dir.pwd
repos.each do |repo|
  puts "-"*15 + " " + repo + " " + "-"*15

  unless system "git clone https://github.com/#{ username }/#{ repo }.git repo && cd repo && git branch #{ branch } && git push origin #{branch} && cd - && rm -rf repo"
    system "cd #{ dir } && rm -rf repo"
    errs << repo
  end
end

errs.each do |e|
  puts "#{e} failed"
end
