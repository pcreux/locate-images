require "spec_helper"

describe LocateImages::LoadImage do
  it "loads an Image with its coordinates" do
    image = LocateImages::LoadImage.call(path: "spec/gps_images/image_a.jpg")

    expect(image).to have_attributes(
      path: "spec/gps_images/image_a.jpg",
      lat: 50.09133333333333,
      long: -122.94566666666667
    )
  end

  it "supports images without coodinates" do
    image = LocateImages::LoadImage.call(path: "spec/gps_images/image_d.jpg")

    expect(image).to have_attributes(
      path: "spec/gps_images/image_d.jpg",
      lat: nil,
      long: nil
    )
  end
end
