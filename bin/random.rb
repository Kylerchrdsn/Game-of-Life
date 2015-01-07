#! /usr/bin/env ruby
require_relative '../lib/life.rb'
field = Life::Field.new(60,100)
field.random
field.evolve 2000

