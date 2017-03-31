require 'optparse'

module LocateImages
  class CLI
    def self.run
      new.call
    end

    def call
      initialize_default_options
      parse_options
      run
    end

    def initialize_default_options
      @directory = "."
      @format = "csv"
      @output = $stdout
    end

    def parse_options
      OptionParser.new do |opts|
        opts.banner = "Usage: locate-images [options] [directory]"

        opts.on("-f", "--format FORMAT", ["csv", "html"], "csv by default. Accepts `csv` or `html`") do |f|
          @format = f
        end

        opts.on("-o", "--output FILE", "stdout by default") do |f|
          @output = File.open(f, 'w')
        end
      end.parse!

      @directory = ARGV[0] if ARGV[0]

      raise "You can only pass one directory" if ARGV.size > 1

    rescue => e
      puts e.message
      exit 1
    end

    def run
      formatter.call(image_paths: ListImages.call(directory: @directory), output: @output)
    end

    def formatter
      {
        "csv" => GenerateCSV,
        "html" => GenerateHTML
      }.fetch(@format)
    end
  end
end
