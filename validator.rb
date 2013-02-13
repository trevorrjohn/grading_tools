#!/usr/bin/ruby
require 'curb'

base_url = ".github.com/"
queries = %w(index.html resume.html bio.html)
html_prefix = "http://validator.w3.org/check?uri="
html_postfix = "&charset=%28detect+automatically%29&doctype=Inline&group=0"
css_prefix = "http://jigsaw.w3.org/css-validator/validator?uri="
css_postfix = "&profile=css3&usermedium=all&warning=1&vextwarning=&lang=en"

ARGV.each do |username|
  puts "*"*40 + " " + username + " " + "*"*40
  puts username + ".github.com"
  puts "github.com/#{username}/#{username}.github.com/"
  queries.each do |q|
    html = html_prefix + username + base_url + q + html_postfix
    curl = Curl::Easy.new(html)
    begin
      curl.perform
    rescue
      assert(true, "#{username} - #{q} failed for html")
    end
    if curl.body_str.match('class="invalid">Errors')
      puts "#{username} - Errors found for #{q} in HTML"
    end

    css = css_prefix + username + base_url + q + css_postfix
    curl = Curl::Easy.new(css)
    begin
      curl.perform
    rescue
      assert(true, "#{q} failed for css")
    end
    if curl.body_str.match('id="errors"')
      puts "#{username} - Errors found for #{q} in CSS"
    end
  end
  puts "="*80
end

exec 'osascript -e "beep 5"'
