require 'spec_helper'
require 'carrierwave/test/matchers'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
    password: "Nicolas1", password_confirmation: "Nicolas1") 

    AvatarUploader.enable_processing = true
    
    @uploader = AvatarUploader.new(@user, :avatar)
    @uploader.store!(File.open("/home/nicoz/Pictures/mario.png"))
  end

  after do
    AvatarUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the tiny version' do
    it "should scale down a landscape image to be exactly 64 by 64 pixels" do
      @uploader.tiny.should have_dimensions(64, 64)
    end
  end

  context 'the small version' do
    it "should scale down a landscape image to fit within 128 by 128 pixels" do
      @uploader.small.should be_no_larger_than(128, 128)
    end
  end

  context 'the big version' do
    it "should scale down a landscape image to fit within 256 by 256 pixels" do
      @uploader.big.should be_no_larger_than(256, 256)
    end
  end
end
