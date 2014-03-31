Given(/^a user that visits the profile page$/) do
  visit profile_path
end

Then(/^he should be redirected to the root page$/) do
  expect(page).to have_link("Inicio", href: root_path)
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


