module LocateImages
  class CLI
    def self.run
      ListImages.call(directory: "gps_images").each do |path|
        p LoadImage.call(path: path)
      end
    end
  end
end
