require 'rubygems'
require 'bundler'

Bundler.require

Dir.glob("lib/*.rb").each { |r| require "./#{r}" }
Dir.glob("models/*.rb").each { |r| require "./#{r}" }
Dir.glob("controllers/*.rb").each { |r| require "./#{r}" }

require './application'
run SportsPresentation