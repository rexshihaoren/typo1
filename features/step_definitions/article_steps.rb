Given /the following users exist:$/ do |users|
	User.create!(users.hashes)
end

Given /the following articles exist:$/ do |articles|
	Article.create!(articles.hashes)
end

Given /the following comments exist:$/ do |comments|
	Comment.create!(comments.hashes)
end


Given /I am logged in as "(.*)" with password "(.*)"$/ do |user, password|
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => password
  click_button 'Login'
  assert page.has_content?('Login successful')
end



Given /the articles with ids (\d+) and (\d+) were merged$/ do |id1, id2|
	Article.find(id1).merge_with(id2)
end

Then /"(.*)" should be author of (\d+) articles$/ do |user, count|
  	Article.find_all_by_author(user).size()==count
end