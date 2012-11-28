unless defined? Dimensions::VERSION
  $:.unshift File.expand_path("../lib", __FILE__)
  require "pdg/version"
end

Gem::Specification.new do |s|
  s.name         = "pdg"
  s.version      = PDG::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Alex Pearce"]
  s.email        = "alex@alexpearce.me"
  s.homepage     = "http://rubygems.org/pdg"
  s.summary      = "PDG data for Ruby."
  s.description  = "Accessible Ruby API to PDG particle data tables."
  s.files        = Dir["lib/**/*.rb", "lib/pdg/mass_width_2012.mcd", "README.md", "LICENSE"]
  s.require_path = "lib"
end
