module LocateImages
  class CLI
    def self.run
      puts GenerateCSV.call(image_paths: ListImages.call(directory: "gps_images"))
    end
  end
end
