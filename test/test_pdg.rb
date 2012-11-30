require "test/unit"
require "pdg"

# We test particles with and without widths,
# and with fractional and integer charges.
class TestPDG < Test::Unit::TestCase
  TOP_ID       = 6
  PROTON_ID    = 2212
  LAMBDA_C_ID  = 4122

  def test_initialization
    assert_equal PDG::ParticleTable, pdg.class
  end

  def test_array_accessor
    assert_equal PDG.particles[PROTON_ID], PDG[PROTON_ID]
  end

  def test_ids
    assert_equal top.id, TOP_ID
    assert_equal proton.id, PROTON_ID
    assert_equal lambda_c.id, LAMBDA_C_ID
  end

  def test_names
    assert_equal "t", top.name
    assert_equal "p", proton.name
    assert_equal "Lambda(c)", lambda_c.name
  end

  def test_masses
    assert_equal 1.73500000E+02, top.mass
    assert_equal 9.38272046E-01, proton.mass
    assert_equal 2.28646000E+00, lambda_c.mass
  end

  def test_mass_alias
    assert_equal 1.73500000E+02, top.m
  end

  def test_charges
    assert_equal Rational(2, 3).to_f, top.charge
    assert_equal 1.0, proton.charge
    assert_equal 1.0, lambda_c.charge
  end

  def test_charge_alias
    assert_equal Rational(2, 3).to_f, top.q
  end

  def test_widths
    assert_equal 2.00E+00, top.width
    assert_equal 0.00E+00, proton.width
    assert_equal 3.30E-12, lambda_c.width
  end

  # We round as we're comparing arbitrary precision
  def test_lifetimes
    assert_equal 3.29106E-13, top.lifetime.round(18)
    assert_equal 0.00000E+00, proton.lifetime
    assert_equal 1.99458E-01, lambda_c.lifetime.round(6)
  end

  def test_lifetime_alias
    assert_equal 3.29106E-13, top.tau.round(18)
  end

  def test_ctau
    assert_equal 9.86635E-14, top.ctau.round(19)
    assert_equal 0.00000E+00, proton.ctau
    assert_equal 5.97961E-02, lambda_c.ctau.round(7)
  end

  def test_mean_distance
    assert_equal 5.65751E-14, top.mean_distance(200).round(19)
    assert_equal 0.00000E+00, proton.mean_distance(10)
    assert_equal 2.54595E-01, lambda_c.mean_distance(10).round(6)
    assert_raise(PDG::LorentzViolation) { top.mean_distance(100) }
  end
  
  def test_pretty_print
    assert_equal String, pdg.pretty_print(PROTON_ID).class
    assert_equal String, pdg.pretty_print(0..100).class
  end

  private
  def pdg
    PDG.particles
  end

  def top
    pdg[TOP_ID]
  end

  def proton
    pdg[PROTON_ID]
  end
  
  def lambda_c
    pdg[LAMBDA_C_ID]
  end
end
