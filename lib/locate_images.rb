require 'pathname'
require 'exifr'

require "locate_images/version"
require "locate_images/cli"

module LocateImages
  class ListImages
    def self.call(directory: ".")
      Dir[Pathname.new(directory) + "*"].select do |path|
        !File.directory?(path) && [".jpg", ".jpeg"].include?(File.extname(path))
      end
    end
  end

  class Image
    attr_accessor :path, :lat, :long

    def initialize(path:, lat:nil, long:nil)
      @path = path
      @lat = lat
      @long = long
    end
  end

  class LoadImage
    def self.call(path:)
      image = Image.new(path: path)

      if gps = EXIFR::JPEG.new(path).gps
        image.lat  = gps.latitude
        image.long = gps.longitude
      end

      image
    end
  end
end
