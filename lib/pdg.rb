require "pdg/particle_table"
require "pdg/particle"

module PDG
  # Reduced Planck's constant in GeV ps
  HBAR = 6.5821193E-13
  # Speed of light in mm ps^-1
  # "C" is a little short for a variable name...
  SPEED_OF_LIGHT = 2.9979246E-01
  # Path to PDG MC table
  DEFAULT_DATA = File.expand_path("../pdg/mass_width_2012.mcd", __FILE__)

  class << self
    # Returns a ParticleTable object
    def particles(path = DEFAULT_DATA)
      @@particles ||= ParticleTable.new(path)
    end

    # Convenience method
    # Returns the particle with `id`
    def [](id)
      particles[id]
    end
  end
end
