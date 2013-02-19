#!/usr/bin/ruby

repos = %w()
errs = []
username = ""
branch = ""
dir = Dir.pwd
repos.each do |repo|
  puts "-"*15 + " " + repo + " " + "-"*15

  unless system "git clone https://github.com/#{ username }/#{ repo }.git repo && cd repo && git push origin :#{ branch } && cd - && rm -rf repo"
    system "cd #{ dir } && rm -rf repo"
    errs << repo
  end
end

errs.each do |e|
  puts "#{e} failed"
end
