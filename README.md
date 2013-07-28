large_binomials
===============

This gem mixes in some general methods to calculate binomials to `Integer`. In
addition, it also mixes in some methods to calculate large binomials, with
“large” being defined as having a result greater than `Float.MAX`. The main
`Integer#binomial(k)` method is then adjusted such that when the result is less
than or equal to `Float.MAX`, an `Integer` is returned, and a
`LargeBinomials::LargeFloat` otherwise. Continuing to use `Integer` makes the
calculation of binomials more and more expensive as the result becomes larger
and larger.

Installation
------------

Do the following to install this gem:

1. Make a clone of the repository
2. Build the gem: `gem build large_binomials.gemspec`
3. Install the gem: `gem install ./large_binomials-0.1alpha1.gem`

Usage
-----

License
-------

Library to calculate large binomials
Copyright (C) 2013  Filip van Laenen <f.a.vanlaenen@ieee.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.