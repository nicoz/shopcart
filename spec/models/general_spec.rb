# == Schema Information
#
# Table name: generals
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  slogan     :string(255)
#  icon       :string(255)
#  logo       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe General do
  before { @general = General.new(name: "Example General", title: "Example General",
    slogan: "Example General") }

  subject { @general }
  
  it { should respond_to(:name) }
  it { should respond_to(:title) }
  it { should respond_to(:slogan) }
  it { should respond_to(:icon) }
  it { should respond_to(:logo) }
end
