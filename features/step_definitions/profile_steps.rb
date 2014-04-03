include ApplicationHelper

Given(/^a user that visits the profile page$/) do
  visit profile_path
end

Then(/^he should be redirected to the root page$/) do
  expect(page).to have_title( full_title('Inicio') )
end

Then(/^he should see the profile page$/) do
  expect(page).to have_content("Perfil del Usuario")
end

Then(/^the profile page should have his name$/) do
  expect(page).to have_title(@user.name)
end

When (/^he visits the profile page$/) do
  visit profile_path
end

Then(/^he should see an information message$/) do
  expect(page).to have_selector('div.alert.alert-info')
end

When(/^he tries to visit the other users profile page$/) do
  visit user_path(@other)
end

