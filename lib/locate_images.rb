require "locate_images/version"
require "locate_images/cli"

require 'pathname'

module LocateImages
  class ListFiles
    def self.call(directory: ".")
      Dir[Pathname.new(directory) + "*"].select { |path| !File.directory?(path) }
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
