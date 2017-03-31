require 'optparse'

module LocateImages
  class CLI
    def self.run
      directory = ARGV[0] || "."
      format = "csv"

      OptionParser.new do |opts|
        opts.banner = "Usage: example.rb [options]"

        opts.on("-f", "--format FORMAT", ["csv", "html"], "csv by default. Accepts `csv` or `html`") do |f|
          format = f
        end
      end.parse!

      formatter = case format
      when "csv"
        GenerateCSV
      when "html"
        GenerateHTML
      end

      puts formatter.call(image_paths: ListImages.call(directory: directory))
    end
  end
end
