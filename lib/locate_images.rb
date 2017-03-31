require "locate_images/version"
require "locate_images/cli"

require 'pathname'

module LocateImages
  class ListFiles
    def self.call(directory: ".")
      Dir[Pathname.new(directory) + "*"].select { |path| !File.directory?(path) }
    end
  end
end
