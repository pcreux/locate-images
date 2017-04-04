require "spec_helper"

describe LocateImages::OutputFormatter do
  let(:image_paths) do
    ["spec/gps_images/cats/image_e.jpg", "spec/gps_images/image_d.jpg"]
  end
  let(:out) { StringIO.new }
  let(:images) { LocateImages::LoadImages.call(image_paths: image_paths) }

  describe LocateImages::GenerateCSV do
    it "generates a csv" do
      LocateImages::GenerateCSV.call(images: images, output: out)

      expect(out.string).to eq "Path,Lat,Long
spec/gps_images/cats/image_e.jpg,59.924755555555556,10.695597222222222
spec/gps_images/image_d.jpg,,
"
    end
  end

  describe LocateImages::GenerateHTML do
    it "generates an html page" do
      LocateImages::GenerateHTML.call(images: images, output: out)

      expect(out.string).to eq "<html>
<body>
<table>
<tr>
<td>spec/gps_images/cats/image_e.jpg</td>
<td>59.924755555555556</td>
<td>10.695597222222222</td>
</tr>
<tr>
<td>spec/gps_images/image_d.jpg</td>
<td></td>
<td></td>
</tr>
</table>
</body>
</html>
"
    end
  end

end
