#
# This code generates barcodes in form of png-files with given input.
# @author Stefan Åhman, stefan.ahman@gmail.com
#
require 'optparse'
require 'fileutils'
require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'

options = {
  out: 'out',
}

o = OptionParser.new do |opts|
  opts.banner = "Usage: ruby barcode-generator.rb [options]"

  opts.on("-d", "--data DATA", String, "Input data") do |data|
    options[:data] = data
  end
end

begin
  o.parse!
rescue OptionParser::InvalidOption => e
  puts e
  puts o
  exit 1
end

FileUtils.mkdir_p(options[:out]) unless File.directory?(options[:out])

barcode = Barby::Code128.new(options[:data])

File.open("#{options[:out]}/#{options[:data]}.png", "w") do |f|
  f.write barcode.to_png({xdim: 2, height: 180})
end
