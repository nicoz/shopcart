# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
 
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
    
  version :icon do
    process :resize_to_fill => [20, 20]
  end
  
  version :tiny do
    process :resize_to_fill => [64, 64]
  end
  
  version :small do
    process :resize_to_fill => [128,128]
  end

  version :big do
    process :resize_to_fill => [256,256]
  end
end
