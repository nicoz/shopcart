new_name = "New Name" 
new_email = "new@example.com" 
old_password = 'Nicolas1'
new_password = 'Nicolas2'

When(/^he visits the user edit page$/) do
  click_link("editar")
end

Then(/^he should see the user edit page$/) do
  expect(page).to have_content("Editar datos del usuario")
end

Then(/^the user edit page should have a form with all the relevant inputs$/) do
  expect(page).to have_selector("form#edit_user")
end

Then(/^the user edit page should a submit button$/) do
  expect(page).to have_button("Confirmar")
end

Then /^he fills incorrect user information$/ do
  fill_in "user_name", with: ''
  fill_in "user_email", with: ''
  click_button ("Confirmar")
end

Then /^he fills correct user information$/ do
  fill_in "user_name", with: new_name
  fill_in "user_email", with: new_email
  click_button ("Confirmar")
end

Then /^he should see the errors$/ do
  expect(page).to have_selector("div.alert.alert-danger.alert-dismissable")
end

Then(/^he should see the new user information$/) do
  expect(page).to have_content("Perfil del Usuario")
  expect(@user.reload.name).to  eq new_name 
  expect(@user.reload.email).to eq new_email 
end

Then(/^he should see the user edit password page$/) do
  expect(page).to have_content("Cambiar Contraseña")
end

Then(/^the user edit password page should have a form with all the relevant inputs$/) do
  expect(page).to have_selector("form#edit_user_password")
end

When(/^he visits the user edit password page$/) do
  click_link("Cambiar Contraseña")
end

When(/^he tries to visit the user edit password page$/) do
  visit edit_password_path(@user)
end


When(/^he fills incorrect user password information$/) do
  click_button ("Confirmar")
end

When(/^he fills incorrect old password information$/) do
  fill_in "user_old_password", with: ''
  fill_in "user_password", with: new_password
  fill_in "user_password_confirmation", with: new_password
  click_button ("Confirmar")
end


When(/^he fills correct user password information$/) do
  fill_in "user_old_password", with: old_password  
  fill_in "user_password", with: new_password
  fill_in "user_password_confirmation", with: new_password
  click_button ("Confirmar")
end

Given(/^an anonymous user$/) do
  sign_out if signed_in?
end

When(/^he visits tries to visit the user edit page$/) do
  @user = User.create(name: "Example User", email: "example@email.com", 
    password: "Nicolas1", password_confirmation: "Nicolas1")
  visit edit_user_path(@user)
end

When(/^he tries to patch the user password data$/) do
  @user = User.create(name: "Example User", email: "example@email.com", 
    password: "Nicolas1", password_confirmation: "Nicolas1")
  sign_out if signed_in?
  patch reset_password_path(@user)
end

When(/^he tries to patch the user data$/) do
  @user = User.create(name: "Example User", email: "example@email.com", 
    password: "Nicolas1", password_confirmation: "Nicolas1")
  patch user_path(@user)
end





