Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^they submit invalid signin information$/ do
  click_button "Ingresar a la tienda"
end

Then /^they should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-warning')
end

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "example@email.com", 
    password: "Nicolas1", password_confirmation: "Nicolas1")
end

When /^the user submits valid signin information$/ do
  fill_in "session_email", with: @user.email
  fill_in "session_password", with: @user.password
  click_button "Ingresar a la tienda"
end

Then /^they should see the root page$/ do
  expect(page).to have_link("Inicio",     href: root_path) 
end

Then /^they should see a signout link$/ do
  expect(page).to have_link("Cerrar Sesión",     href: signout_path) 
end
