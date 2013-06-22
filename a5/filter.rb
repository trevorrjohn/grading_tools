require 'pry'

@saved = []
@headers = []
@utln = ""
@failed = ""

File.open("output") do |file|
  file.readlines.each do |line|
    @utln = line.match(/-{21,} (\w*) -{21,}/)[1].to_sym if line.match(/-{21,} (\w*) -{21,}/)
    if line.match(/(\d{1,2}\) .*)/)
      match = line.match(/(\d{1,2}\)) Assignment 5 - Scorecenter (.*)/)
      @headers << "#{match[1]} #{match[2]}"
    end
    @failed = line.match(/17 examples, (\d{1,2})/)[1] if line.match(/17 examples, (\d{1,2})/)

    if line.match(/={21,}/)
      @saved << { utln: @utln, failed: @failed, errors: @headers }

      @headers = []
    end
  end
end

File.open("filtered_output.csv", "w") do |file|
  @saved.each do |user|
    errors = user[:errors].inject("") do |memo, error|
      memo <<  "#{error}, "
    end
    file.puts "#{user[:utln]}, #{user[:failed]}, #{errors}"
  end
end
