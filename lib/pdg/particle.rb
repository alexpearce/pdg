require "pdg/lorentz_violation"

module PDG
  class Particle
    attr_reader :id, :name, :charge, :mass, :tex
    attr_accessor :mass, :width

    alias_method :q, :charge
    alias_method :m, :mass

    def initialize(properties)
      properties.update(properties) { |key, val| val.nil? ? 0 : val }
      @id       = properties[:id].to_i
      @name     = properties[:name]
      @charge   = case properties[:charge]
                  when "+"
                    1.0
                  when "++"
                    2.0
                  when "-"
                    -1.0
                  when "--"
                    -2.0
                  # Either 0 or something like -1/3, +2/3
                  else
                    fraction_to_float(properties[:charge])
                  end
      # The mass and width keys may not be present, but never fear as:
      # nil.to_f => 0.0
      @mass     = properties[:mass].to_f
      @width    = properties[:width].to_f
      @tex      = name_to_tex
    end

    # Returns the lifetime in picoseconds (10^-12 s)
    # by Gamma = hbar / tau. Returns 0 for zero lifetimes.
    # (The PDG represent inifinite lifetimes, like that of
    # the proton, as zero.)
    def lifetime
      @lifetime ||= @width == 0.0 ? 0.0 : HBAR / @width
    end
    alias_method :tau, :lifetime

    # Returns c tau distance in mm (10^-3 m)
    def ctau
      @ctau ||= @lifetime == 0.0 ? 0.0 : SPEED_OF_LIGHT * lifetime
    end

    # Returns the mean displacement, in mm, of the particle with energy `energy` in GeV
    def mean_distance(energy)
      return 0.0 if lifetime == 0.0
      if energy < @mass
        raise LorentzViolation,
          "Energy #{energy} GeV is less than particle mass #{@mass} GeV for particle #{self}"
      end

      gamma = energy.to_f / @mass
      beta  = Math.sqrt(1.0 - (gamma**-2))
      ctau * beta * gamma
    end

    # TODO pretty printing
    def to_s
      "#{@name}: ID=#{@id}, m=#{@mass} GeV, q=#{@charge}, width=#{@width} GeV"
    end

    private
    # TODO implement
    def name_to_tex
      @name + ".tex"
    end

    # Returns a float representation of a string fraction
    # fraction_to_float("-2/3") => -0.666...
    def fraction_to_float(fraction)
      return 0.0 if fraction == "0"
      sign = fraction[0] == "+" ? 1.0 : -1.0
      sign * Rational(*(fraction[1..-1].split("/").map(&:to_i))).to_f
    end
  end
end
