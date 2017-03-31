require 'optparse'

module LocateImages
  class CLI
    def self.run
      directory = ARGV[0] || "."
      puts GenerateCSV.call(image_paths: ListImages.call(directory: directory))
    end
  end
end
