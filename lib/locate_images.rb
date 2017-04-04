require 'pathname'
require 'exifr'
require 'csv'

require "locate_images/version"
require "locate_images/cli"

module LocateImages
  class ListImages
    def self.call(directory: ".")
      Dir[Pathname.new(directory) + "**" + "*"].select do |path|
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

  class LoadImages
    def self.call(image_paths:)
      image_paths.
        lazy.
        map { |image_path| LoadImage.call(path: image_path) }
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
    attr_reader :images, :output

    def self.call(*args)
      new(*args).call
    end

    def initialize(images:, output: $stdout)
      @images = images
      @output = output
    end

    def call
      raise NotImplementedError
    end
  end

  class GenerateCSV < OutputFormatter
    def call
      output.puts ["Path", "Lat", "Long"].to_csv

      images.each do |image|
        output.puts [image.path, image.lat, image.long].to_csv
      end
    end
  end

  class GenerateHTML < OutputFormatter
    def call
      output.puts "<html>"
      output.puts "<body>"
      output.puts "<table>"

      images.each do |image|
        output.puts "<tr>"
        output.puts "<td>#{image.path}</td>"
        output.puts "<td>#{image.lat}</td>"
        output.puts "<td>#{image.long}</td>"
        output.puts "</tr>"
      end

      output.puts "</table>"
      output.puts "</body>"
      output.puts "</html>"
    end
  end
end
