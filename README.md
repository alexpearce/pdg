PDG - A Particle Properties Database in Ruby
============================================

Essentially a port of [PyPDT](http://pypi.python.org/pypi/PyPDT), PDG is a Ruby gem for accessing particle properties, as defined by the [Particle Data Group](http://pdg.lbl.gov/).

The units are millimetres (mm) for distance, picoseconds (ps) for time, and gigaelectronvolts (GeV) for energy.

An example usage:

```ruby
> require "pdg"
> PDG[4122]
=> Lambda(c): ID=4122, m=2.28646 GeV, q=1.0, width=3.3e-12 GeV
# Or alternatively
> particles = PDG.particles
> lc = particles[4122]
=> Lambda(c): ID=4122, m=2.28646 GeV, q=1.0, width=3.3e-12 GeV
> lc.mass
=> 2.28646
> lc.width
=> 3.3e-12
> lc.mean_distance(20)
=> 0.5196155433341929 
> puts particles.pretty_print(4122)
+------+------+-------------+--------+-------+----------+
| id   | name | mass        | charge | width | lifetime |
+------+------+-------------+--------+-------+----------+
| 2212 | p    | 0.938272046 | 1.0    | 0.0   | 0.0      |
+------+------+-------------+--------+-------+----------+
> puts particles.pretty_print(1..100)
+----+-------+----------------+---------------------+---------------+------------------------+
| id | name  | mass           | charge              | width         | lifetime               |
+----+-------+----------------+---------------------+---------------+------------------------+
| 1  | d     | 0.0048         | -0.3333333333333333 | 0.0           | 0.0                    |
| 2  | u     | 0.0023         | 0.6666666666666666  | 0.0           | 0.0                    |
| 3  | s     | 0.095          | -0.3333333333333333 | 0.0           | 0.0                    |
| 4  | c     | 1.275          | 0.6666666666666666  | 0.0           | 0.0                    |
| 5  | b     | 4.18           | -0.3333333333333333 | 0.0           | 0.0                    |
| 6  | t     | 173.5          | 0.6666666666666666  | 2.0           | 3.29105965e-13         |
| 11 | e     | 0.000510998928 | -1.0                | 0.0           | 0.0                    |
| 13 | mu    | 0.105658372    | -1.0                | 2.9959848e-19 | 2196980.2049730024     |
| 15 | tau   | 1.77682        | -1.0                | 2.265e-12     | 0.290601293598234      |
| 21 | g     | 0.0            | 0.0                 | 0.0           | 0.0                    |
| 22 | gamma | 0.0            | 0.0                 | 0.0           | 0.0                    |
| 23 | Z     | 91.1876        | 0.0                 | 2.4952        | 2.6379125120230843e-13 |
| 24 | W     | 80.385         | 1.0                 | 2.085         | 3.1568917505995203e-13 |
+----+-------+----------------+---------------------+---------------+------------------------+
```

All available particle properties are given as instance methods in the [`Particle` class](https://github.com/alexpearce/pdg/blob/master/lib/pdg/particle.rb).

The `ParticleTable` class, which is returned by `PDG.particles`, inherits from `Hash` and so has all of its parent's methods, including an ability to select objects with a `Range`.

```ruby
> particles = PDG.particles
> particles[1..100].length
=> 13
```

Alternative Data Sources
------------------------

Note that not all particles are included by default. This is due to them not being present in the PDG-provided [source data](http://pdg.lbl.gov/2012/mcdata/mass_width_2012.mcd) (the PDG have been contacted about this).
There is an [older version](http://pdg.lbl.gov/rpp/mcdata/mass_width_02.mc) available with more particles but outdated properties. This can be used as an alternative source file.

```
$ irb

> require "pdg"
> PDG[12]
=> nil
> exit

$ wget http://pdg.lbl.gov/rpp/mcdata/mass_width_02.mc 
$ irb

> require "pdg"
> particles = PDG.particles("mass_width_02.mc")
> PDG[12]
=> 
```

Testing
-------

You can run the tests on the gem source.

```bash
$ git clone git://github.com/alexpearce/pdg.git 
$ cd pdg
$ bundle install --path=vendor/bundle
$ rake
```

Contributions
-------------

This gem is very much in its infancy. If there are features you would like to see, or incorrect implementations that need fixing, do [submit an issue](https://github.com/alexpearce/pdg/issues) or email me.

Other
-----

[ISC licensed](https://github.com/alexpearce/pdg/blob/master/LICENSE)

[![Build Status](https://secure.travis-ci.org/alexpearce/pdg.png?branch=master)](https://travis-ci.org/alexpearce/pdg)
