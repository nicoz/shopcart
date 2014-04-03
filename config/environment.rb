# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Shopcart::Application.initialize!

# Configuration for using SendGrid on Heroku
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "app22903745@heroku.com",
  :password => "yx0uxod4",
  :domain => "imaginatio-shopcart.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}


