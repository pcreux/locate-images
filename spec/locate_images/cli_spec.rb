require 'fileutils'

describe "locate-images CLI" do

  describe "locate-images" do
    it "locates images in the current directory and outputs a csv file" do
      output = run!
      lines = output.split("\n")
      expect(lines.first).to eq "Path,Lat,Long"

      expect(lines.size).to eq 6
    end
  end

  describe "locate-images -f html" do
    it "locates images in the current directory and outputs an html file" do
      output = run!("-f html")
      lines = output.split("\n")
      expect(lines.first).to eq "<html>"
    end
  end

  describe "locate-images -o spec/csv.out" do
    it "locates images in the current directory and outputs a csv to a file" do
      output = run!("-o csv.out")
      expect(output).to eq("")

      file_content = File.read("spec/csv.out")
      lines = file_content.split("\n")

      expect(lines.first).to eq "Path,Lat,Long"
    end

    after { FileUtils.rm("spec/csv.out") }
  end

  describe "locate-images spec/gps_images/cats" do
    it "locates images in the directory passed in" do
      output = run!("gps_images/cats")
      expect(output).to eq("Path,Lat,Long
gps_images/cats/image_e.jpg,59.924755555555556,10.695597222222222
")
    end
  end

  describe "locate-images -f html -o spec/html.out spec/gps_images/cats" do
    it "does it all" do
      output = run!("-f html -o html.out spec/gps_images/cats")
      expect(output).to eq("")

      file_content = File.read("spec/html.out")
      lines = file_content.split("\n")

      expect(lines.first).to eq "<html>"
    end

    after { FileUtils.rm("spec/html.out") }
  end

  def run!(options="")
    `cd spec && ../exe/locate-images #{options}`
  end
end
