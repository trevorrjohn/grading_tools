#!/usr/bin/ruby
require 'w3c_validators'

include W3CValidators
query = "/where/index.html"
base_url = "http://tuftsdev.github.com/"

repos = [].shuffle
@validator = MarkupValidator.new
errors = {}
repos.each do |repo|
  url = base_url + repo + query
  puts url
  results = @validator.validate_uri( url )
  if results.errors.length > 0
    errors[repo] = results.errors
  end
end

errors.map do |repo, error|
  puts "-"*15 + " " + repo + " " + "-"*15
  puts error.inspect
end
