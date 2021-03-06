# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  #include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :file
   storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{ENV["FP_LOCATION"]}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  def filename
    if original_filename
      #ext = original_filename.match(/\.(jpg|jpeg|png|gif)/)[1]
      model.title.downcase.gsub(/\s/,"_")+".#{file.extension}"
    end
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
     # For Rails 3.1+ asset pipeline compatibility:
     # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
     size={
       :small =>125,
       :feature =>200
     }
     ActionController::Base.helpers.asset_path("bang_#{size[version_name]}.png")

   end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  process resize_to_fill: [250,250]

  version :small do
    process resize_to_fit:  [125,125]
  end 

  version :feature do
    process resize_to_fit: [200,200]
  end
  

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  #def crop
    #if model.crop_x.present?
      #manipulate! do |img|
        #x = model.crop_x.to_i
        #y = model.crop_y.to_i
        #w = model.crop_w.to_i
        #h = model.crop_h.to_i
        #img.crop!(x,y,w,h)
        ##img.resize_to_fit!(400,400)
      #end
    #end 
  #end
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
