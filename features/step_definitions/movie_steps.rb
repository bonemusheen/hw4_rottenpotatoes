Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |e1, e2|
  Movie.find_by_title(e1).director.should eq e2
end
# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should =~ /#{e1}.*#{e2}/m
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |rating|
    uncheck == "un" ? uncheck("ratings_#{rating}") : check("ratings_#{rating}")
  end
end

Then /I should see the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each { |rating| page.body.should match(Regexp.new("<td>#{rating}</td>")) }
end

Then /I should not see the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each { |rating| page.body.should_not match(Regexp.new("<td>#{rating}</td>")) }
end

Then /I should not see none of the movies/ do
  page.body.scan(/<tr>/).length.send(:-, 1).should_not eq 0
end

Then /I should see all of the movies/ do
  page.body.scan(/<tr>/).length.send(:-, 1).should eq Movie.all.count
end