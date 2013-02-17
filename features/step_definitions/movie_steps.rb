Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end


Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie_title, director|
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
#And /^I should see "([^"]*)" before "([^"]*)"$/ do |phrase_1, phrase_2|
  begin
    e1 = Date.parse(e1).to_s
  rescue ArgumentError => e
  end

  begin
    e2 = Date.parse(e2).to_s
  rescue ArgumentError => e
  end

  index1 = page.body.index(e1)
  index2 = page.body.index(e2)
  index1.should < index2
end
