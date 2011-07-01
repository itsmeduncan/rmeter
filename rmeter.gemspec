$LOAD_PATH.unshift 'lib'
require 'rmeter/version'

Gem::Specification.new do |s|
  s.name              = "rmeter"
  s.version           = Rmeter::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "RMeter is a ruby frontend to JMeter."
  s.homepage          = "http://www.google.com"
  s.email             = "paul.guelpa@gmail.com"
  s.authors           = [ "Paul Guelpa" ]

  s.files             = %w( README.markdown Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("rspec/**/*")

  s.extra_rdoc_files  = [ "LICENSE", "README.markdown" ]
  s.rdoc_options      = ["--charset=UTF-8"]

  s.description = <<description
    Fooscription
description
end
