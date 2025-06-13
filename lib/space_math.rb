# typed: strict
# frozen_string_literal: true

require 'bundler/setup'

Bundler.require(:default, ENV['APP_ENV'] || 'development')

require_relative 'space_math/planet'
require_relative 'space_math/fuel_calculator'
require_relative 'space_math/mission'
require_relative 'space_math/mission_step'

module SpaceMath
  extend T::Sig

  module_function

  sig { params(mass: Integer, mission: Mission).returns(Integer) }
  def mission_calculate(mass, mission)
    Kernel.raise ArgumentError, 'Mass must be positive' if mass.negative?

    mission.validate!

    original_mass = mass

    mission.steps.each do |step|
      if step.launch?
        mass += FuelCalculator.for_launch(mass, step.planet.gravity)
      elsif step.land?
        mass += FuelCalculator.for_landing(mass, step.planet.gravity)
      end
    end

    mass - original_mass
  end
end
