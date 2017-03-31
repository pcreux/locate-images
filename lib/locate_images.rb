require "locate_images/version"
require "locate_images/cli"

require 'pathname'

module LocateImages
  class ListImages
    def self.call(directory: ".")
      Dir[Pathname.new(directory) + "*"].select do |path|
        !File.directory?(path) && [".jpg", ".jpeg"].include?(File.extname(path))
      end
    end
  end

  class Image
    attr_reader :path, :lat, :long

    def initialize(path:, lat:nil, long:nil)
      @path = path
      @lat = lat
      @long = long
    end
  end

  class LoadImage
    def self.call(path:)
      Image.new(path: path)
    end
  end
end
