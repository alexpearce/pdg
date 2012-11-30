require "pdg/particle_table"
require "pdg/particle"

require "hirb"

module PDG
  # Reduced Planck's constant in GeV ps
  HBAR = 6.5821193E-13
  # Speed of light in mm ps^-1
  # "C" is a little short for a variable name...
  SPEED_OF_LIGHT = 2.9979246E-01
  # Path to PDG MC table
  DEFAULT_DATA = File.expand_path "../pdg/mass_width_2012.mcd", __FILE__

  class << self
    # Returns a ParticleTable object
    def particles(path = DEFAULT_DATA)
      @@particles ||= ParticleTable.new path
    end

    # Convenience method
    # Returns the particle with `id`
    def [](id)
      particles[id]
    end

    def pretty_print(objs, properties)
      Hirb::Helpers::AutoTable.render objs, {:fields => properties}
    end

    # Ruby 1.8:
    # "Hello"[0] => 72
    # Ruby 1.9:
    # "Hello"[0] => "H"
    # assuming non-multibyte strings.
    # This functions returns the ASCII representation of the `idx`th byte of the string
    def single_character(str, idx = 0)
      substr = str[idx]
      substr.class == Fixnum ? substr.chr : substr
    end
  end
end
