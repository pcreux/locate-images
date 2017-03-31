require 'optparse'

module LocateImages
  class CLI
    def self.run
      directory = ARGV[0] || "."
      format = "csv"
      output = $stdout

      OptionParser.new do |opts|
        opts.banner = "Usage: example.rb [options]"

        opts.on("-f", "--format FORMAT", ["csv", "html"], "csv by default. Accepts `csv` or `html`") do |f|
          format = f
        end

        opts.on("-o", "--output FILE", "stdout by default") do |f|
          output = File.open(f, 'w')
        end
      end.parse!

      formatter = case format
      when "csv"
        GenerateCSV
      when "html"
        GenerateHTML
      end

      formatter.call(image_paths: ListImages.call(directory: directory), output: output)
    end
  end
end
