require "pdg/particle.rb"

module PDG
  class ParticleTable
    def initialize(path)
      @particles = Hash.new

      source = File.new(path, "r")

      while (line = source.gets)
        line_type = line[0]

        case line_type
        # Comment lines begin with a *
        when "*"
          next
        when "M"
          parse_line(line, :mass)
        when "W"
          parse_line(line, :width)
        end

      end

      source.close
    end

    # Parses a line from the PDG MC data
    # Passes the information to the add_row method
    def parse_line(line, type)
      names_charges = line[68..88].split

      ids        = line[1..32].split
      name       = names_charges[0]
      charges    = names_charges[1].split(",")
      type_value = line[34..48].strip

      ids.each_index do |i|
        add_row({
            :id     => ids[i],
            :name   => name,
            :charge => charges[i],
            type    => type_value.to_f
        })
      end
    end

    # Adds a row with the corresponding properties to the table
    def add_row(particle_properties)
      particle = self[particle_properties[:id]]
      if particle.nil?
        self << Particle.new(particle_properties)
      else
        particle.mass  = particle_properties[:mass] unless particle_properties[:mass].nil?
        particle.width = particle_properties[:width] unless particle_properties[:width].nil?
      end
    end

    # Convenience method
    def [](id)
      @particles[id.to_i]
    end

    # Appends a new particle to the `particles` hash
    def <<(particle)
      @particles[particle.id] = particle
    end

    # Iterate over the values of the hash
    def each(&block)
      @particles.each_value(&block)
    end

    def to_s
      "<##{self.class}:#{self.object_id.to_s(8)}>"
    end

    protected :<<, :parse_line, :add_row

    private
  end
end
