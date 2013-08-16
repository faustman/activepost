# Load path and gems/bundler
$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require "rubygems"
require "bundler"
Bundler.require

ENV["RACK_ENV"] ||= 'development'

# Local config
require "find"
%w{config/initializers}.each do |load_path|
   Find.find(load_path) { |f| require f unless f.match(/\/\..+$/) || File.directory?(f) }
end

require 'app'
run ActivePost
