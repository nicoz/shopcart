# == Schema Information
#
# Table name: service_informations
#
#  id         :integer          not null, primary key
#  service_id :integer
#  key        :string(255)
#  value      :text(255)
#  created_at :datetime
#  updated_at :datetime
#  active     :boolean          default(TRUE)
#

require 'spec_helper'

describe ServiceInformation do
  before { @serviceInformation = ServiceInformation.new( service_id: 1, key: "username",
                                                         value: "coso"
  ) }

  subject { @serviceInformation }

  describe "when service_id is not present" do
    before { @serviceInformation.service_id = nil }
    it { should_not be_valid }
  end

  describe "when service_id is present" do
    before { @serviceInformation.service_id = 1 }
    it { should be_valid }
  end

  describe "when key is not present" do
    before { @serviceInformation.key = ""; }
    it { should_not be_valid }
  end

  describe "when key is present" do
    before { @serviceInformation.key = "username"; }
    it { should be_valid }
  end

  describe "when value is not present" do
    before { @serviceInformation.value = "" }
    it { should_not be_valid }
  end

  describe "when value is present" do
    before { @serviceInformation.value = "servicio1" }
    it { should be_valid }
  end
end
