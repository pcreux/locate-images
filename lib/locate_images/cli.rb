module LocateImages
  class CLI
    def self.run
      p ListFiles.call(directory: "gps_images")
    end
  end
end
