require "spec_helper"

describe LocateImages::LoadImages do
  let(:image_paths) do
    ["spec/gps_images/cats/image_e.jpg", "spec/gps_images/image_a.jpg"]
  end

  it "returns an lazy enumerator of Images for the path passed in" do
    images = LocateImages::LoadImages.call(image_paths: image_paths)

    expect(images).to be_a(Enumerator::Lazy)

    expect(images.next).to have_attributes(
      path: "spec/gps_images/cats/image_e.jpg",
      lat: 59.924755555555556,
      long: 10.695597222222222
    )

    expect(images.next).to have_attributes(
      path: "spec/gps_images/image_a.jpg",
      lat: 50.09133333333333,
      long: -122.94566666666667
    )
  end
end
