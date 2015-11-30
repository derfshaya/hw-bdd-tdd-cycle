Given(/^the following movies exist:$/) do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |movie, director|
  expect(page.body).to match /#{movie}/m
  expect(page.find('#details').text).to match (/Director:\s*#{director}/m)
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body).to match /#{e1}.+#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |un, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rating|
    step("#{un}check \"ratings_#{rating}\"")
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  page.all('table#movies tr').count.should == Movie.count + 1
end