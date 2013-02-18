#!/usr/bin/ruby

repos = [ ]

repos.each do |repo|
  puts "-"*15 + " " + repo + " " + "-"*15

  unless system "git clone https://github.com/tuftsdev/#{ repo }.git repo; cd repo && git branch gh-pages && git push origin gh-pages && cd - && rm -rf repo"
    raise "Push failed"
  end
end
