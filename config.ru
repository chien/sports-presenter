require 'rubygems'
require 'bundler'

Bundler.require

Dir.glob("lib/*.rb").each { |r| require_relative r }
Dir.glob("controllers/*.rb").each { |r| require_relative r }
require './application'
run SportsPresentation