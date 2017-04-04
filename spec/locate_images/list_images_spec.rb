require "spec_helper"

describe LocateImages::ListImages do
  it "lists images of the directory passed in" do
    images = LocateImages::ListImages.call(directory: "spec/gps_images")
    expect(images).to match_array ["spec/gps_images/cats/image_e.jpg", "spec/gps_images/image_a.jpg", "spec/gps_images/image_b.jpg", "spec/gps_images/image_c.jpg", "spec/gps_images/image_d.jpg"]
  end

  it "does list directories or non-jpg files" do
    images = LocateImages::ListImages.call(directory: "lib")
    expect(images).to eq []
  end
end
