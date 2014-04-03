Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^he submits invalid signin information$/ do
  click_button "Ingresar a la tienda"
end

Then /^he should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-warning')
end

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "example@email.com", 
    password: "Nicolas1", password_confirmation: "Nicolas1")
end

Given(/^there is another user$/) do
  @other = User.create(name: "Example User 2", email: "other@email.com", 
    password: "Nicolas1", password_confirmation: "Nicolas1")
end

When /^the user submits valid signin information$/ do
  fill_in "session_email", with: @user.email
  fill_in "session_password", with: @user.password
  click_button "Ingresar a la tienda"
end

Then /^he should see the root page$/ do
  expect(page).to have_link("Inicio",     href: root_path) 
end

Then /^he should see a signout link$/ do
  expect(page).to have_link("Cerrar Sesión",     href: signout_path) 
end

When (/^he isn't signed in$/) do
  signed_in?
end

Then(/^he shouldnt be signed in$/) do
  !signed_in?
end


Given (/^he is signed in$/) do
  visit signin_path
  fill_in "session_email", with: @user.email
  fill_in "session_password", with: @user.password
  click_button "Ingresar a la tienda"
  signed_in?
end
