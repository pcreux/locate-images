require 'pathname'
require 'exifr'
require 'csv'

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

  class GenerateCSV
    def self.call(image_paths:, output: $stdout)
      output.puts ["Path", "Lat", "Long"].to_csv

      image_paths.each do |image_path|
        new(image_path: image_path, output: output).call
      end
    end

    attr_reader :image_path, :output

    def initialize(image_path:, output: $stdout)
      @image_path = image_path
      @output = output
    end

    def call
      image = LoadImage.call(path: image_path)
      output.puts [image.path, image.lat, image.long].to_csv
    end
  end
end
