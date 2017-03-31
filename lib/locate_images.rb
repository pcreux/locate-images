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

  class OutputFormatter
    attr_reader :image_path, :output

    def initialize(image_path:, output: $stdout)
      @image_path = image_path
      @output = output
      @image = LoadImage.call(path: image_path)
    end

    private

    attr_reader :image
  end

  class GenerateCSV < OutputFormatter
    def self.call(image_paths:, output: $stdout)
      output.puts ["Path", "Lat", "Long"].to_csv

      image_paths.each do |image_path|
        new(image_path: image_path, output: output).call
      end
    end

    def call
      output.puts [image.path, image.lat, image.long].to_csv
    end
  end

  class GenerateHTML < OutputFormatter
    def self.call(image_paths:, output: $stdout)
      output.puts "<html>"
      output.puts "<body>"
      output.puts "<table>"

      image_paths.each do |image_path|
        new(image_path: image_path, output: output).call
      end

      output.puts "</table>"
      output.puts "</body>"
      output.puts "</html>"
    end

    def call
      output.puts "<tr>"
      output.puts "<td>#{image.path}</td>"
      output.puts "<td>#{image.lat}</td>"
      output.puts "<td>#{image.long}</td>"
      output.puts "</tr>"
    end
  end
end
