require 'rubygems'
require 'bundler'
Bundler.require
Dir.glob(File.join(File.dirname(__FILE__),"lib/*.rb")).each { |r| require r }
Dir.glob(File.join(File.dirname(__FILE__), "controllers/*.rb")).each { |r| require r }
require './application'
run SportsPresentation