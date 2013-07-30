# Ruby Library to Calculate Large Binomials
# Copyright © 2013 Filip van Laenen <f.a.vanlaenen@ieee.org>
#
# This file is part of the Ruby Library to Calculate Large Binomials.
#
# The Ruby Library to Calculate Large Binomials is free software: you can
# redistribute it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# 
# The Ruby Library to Calculate Large Binomials is distributed in the hope that
# it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You can find a copy of the GNU General Public License in /LICENSE
#

require 'rspec/core/rake_task'
 
desc 'Default: run specs.'
task :default => :spec
 
desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
	t.pattern = "./spec/**/*_spec.rb"
end

def find_integer_methods
	require_relative 'lib/core_ext/integer'
	integer_methods = Integer.instance_methods(false)
	integer_methods.select!{ | m | 1.method(m).source_location != nil }
	integer_methods.select!{ | m | 1.method(m).source_location[0].include? 'large_binomials'}
	integer_methods.collect{ | m | "::Integer##{m}"}
end

desc 'Run Mutant'
task :mutant do
	require 'mutant'
	find_integer_methods
	status = Mutant::CLI.run(['::LargeBinomials*', find_integer_methods, '--rspec-unit'].flatten)
	if status.nonzero?
		abort 'Mutant task is not successful'
	end
end