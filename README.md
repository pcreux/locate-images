# locate-images

## This is a coding challenge!

[![CircleCI](https://circleci.com/gh/pcreux/locate-images.svg?style=svg)](https://circleci.com/gh/pcreux/locate-images)
[![Code Climate](https://codeclimate.com/github/pcreux/locate-images/badges/gpa.svg)](https://codeclimate.com/github/pcreux/locate-images)


### Instructions

Using Ruby, create a command line application that recursively reads all of the images from the supplied directory of images,
extracts their EXIF GPS data (longitude and latitude), and then writes the name of that image and any GPS co-ordinates it finds to a CSV file.

This utility should be runnable from the command line (i.e.: ‘ruby ./app.rb’) or as an executable.

With no parameters, the utility should default to scanning from the current directory. It should take an optional parameter that allows any other directory to be passed in.

As a bonus, output either CSV or HTML, based on a parameter passed in via the command line.

Feel free to use any gem(s) you like in your submission.

## Installation

    $ gem install locate-images

## Usage

```
$> locate-images

Usage: locate-images [options] [directory]
    -f, --format FORMAT              csv by default. Accepts `csv` or `html`
    -o, --output FILE                stdout by default
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/locate-images. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

