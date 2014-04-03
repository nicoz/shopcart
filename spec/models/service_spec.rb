# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  active     :boolean          default(TRUE)
#

require 'spec_helper'

describe Service do
  before { @service = Service.new( name: "servicio1", enabled: true ) }

  subject { @service }

  it { should be_valid }

  describe "when name is not present" do
    before { @service.name = ""; }
    it { should_not be_valid }
  end

  describe "when enabled not present" do
    before { @service.enabled = nil }
    it { should_not be_valid }
  end

  describe "when name is present and valid" do
    before { @service.name = "servicio1" }
    it { should be_valid }
  end

  describe "when name is present and invalid" do
    before { @service.name = "_/&@·3#coso" }
    it { should_not be_valid }
  end

  describe "when enabled present" do
    before { @service.enabled = true }
    it { should be_valid }
  end
end
