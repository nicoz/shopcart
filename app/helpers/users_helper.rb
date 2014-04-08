module UsersHelper

  def random_password
    "#{(0...3).map { ('a'..'z').to_a[rand(26)] }.join}#{(0...3).map { ('A'..'Z').to_a[rand(26)] }.join}#{(0...3).map { ('0'..'9').to_a[rand(9)] }.join}"
  end
  
  
  def random_email
    "#{(0...12).map { ('a'..'z').to_a[rand(26)] }.join}#{(0...3).map { ('0'..'9').to_a[rand(9)] }.join}@socialmail.com"
  end
  
end
