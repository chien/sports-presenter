Gem::Specification.new do |s|
  s.name = "sports-presenter"
  s.version = "0.0.1"
  s.summary = "Sports Presenter gem for make pretty good"
  s.authors = ["Sean St. Quentin"]
  s.email = ["sean.quentin@iplayup.com"]
  s.files = Dir.glob("./lib/**/*.rb")
  s.files += Dir.glob("./lib/**/*.json")  # For the mocked responses.
  s.files += Dir.glob("./lib/**/*.haml")
  s.files += Dir.glob("./lib/**/*.css")
  s.files += Dir.glob("./lib/**/*.png")
  s.files += Dir.glob("./lib/sports-presenter/public/fonts/*")
end