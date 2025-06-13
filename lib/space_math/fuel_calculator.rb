# typed: strict
# frozen_string_literal: true

module SpaceMath
  module FuelCalculator
    extend T::Sig

    LAUNCH_EFFICIENCY = T.let(0.042, Float)
    LANDING_EFFICIENCY = T.let(0.033, Float)

    LAUNCH_OVERHEAD = T.let(33, Integer)
    LANDING_OVERHEAD = T.let(42, Integer)

    module_function

    sig { params(mass: Numeric, gravity: Float, efficiency: Float, overhead: Integer).returns(Integer) }
    def call(mass, gravity, efficiency, overhead)
      base_fuel = [((mass * gravity * efficiency) - overhead).floor, 0].max
      return base_fuel if base_fuel.zero?

      total_fuel = base_fuel
      current_fuel = base_fuel

      while current_fuel.positive?
        additional = [((current_fuel * gravity * efficiency) - overhead).floor, 0].max
        break if additional.zero?

        total_fuel += additional
        current_fuel = additional
      end

      total_fuel
    end

    sig { params(mass: Numeric, gravity: Float).returns(Integer) }
    def for_launch(mass, gravity)
      call(mass, gravity, LAUNCH_EFFICIENCY, LAUNCH_OVERHEAD)
    end

    sig { params(mass: Numeric, gravity: Float).returns(Integer) }
    def for_landing(mass, gravity)
      call(mass, gravity, LANDING_EFFICIENCY, LANDING_OVERHEAD)
    end
  end
end
