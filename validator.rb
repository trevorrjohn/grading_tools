#!/usr/bin/ruby

queries = %w(index.html resume.html bio.html)

base_url = ".github.com/"
html_prefix = "http://validator.w3.org/check?uri="
html_postfix = "&charset=%28detect+automatically%29&doctype=Inline&group=0"
css_prefix = "http://jigsaw.w3.org/css-validator/validator?uri="
css_postfix = "&profile=css3&usermedium=all&warning=1&vextwarning=&lang=en"

usernames = []
html_failures = []
css_failures = []
errs = []

usernames.each do |username|
  puts "-"*15 + " " + username + " " + "-"*15

  queries.each do |q|
    url = html_prefix + username + base_url + q + html_postfix

    response = `curl -v #{ url } --retry 3`

    if response.empty?
      puts "#{ username } did not respond"
      errs << username
    else reponse.match('class="invalid">Errors')
      puts "#{username} - Errors found for #{q} in HTML"
      html_failures << [username, q].join(" - ")
    end

    url = css_prefix + username + base_url + q + css_postfix

    response = `curl -v #{ url } --retry 3`
    if response.empty?
      puts "#{ username } did not respond"
      errs << username
    else reponse.match('class="invalid">Errors')
      puts "#{username} - Errors found for #{q} in CSS"
      css_failures << [username, q].join(" - ")
    end
  end
end

puts "-"*15 + " Failures " + "-"*15
html_failures.each { |f| puts f }
css_failures.each { |f| puts f }

puts "-"*15 + " Errors " + "-"*15
errs.each { |e| puts e }
