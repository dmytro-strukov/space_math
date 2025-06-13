# typed: strict
# frozen_string_literal: true

module SpaceMath
  class MissionStep
    extend T::Sig

    PLANETS = T.let(
      {
        earth: Planet.new(name: :earth, gravity: 9.807),
        moon: Planet.new(name: :moon, gravity: 1.62),
        mars: Planet.new(name: :mars, gravity: 3.711)
      }, T::Hash[Symbol, Planet]
    )

    ACTIONS = T.let({
                      launch: :launch,
                      land: :land
                    }, T::Hash[Symbol, Symbol])

    sig { returns(Symbol) }
    attr_reader :action

    sig { returns(Symbol) }
    attr_reader :planet_name

    sig { returns(Planet) }
    attr_reader :planet

    sig { params(action: Symbol, planet_name: Symbol).void }
    def initialize(action, planet_name)
      @action = T.let(ACTIONS.fetch(action), Symbol)
      @planet_name = planet_name
      @planet = T.let(PLANETS.fetch(planet_name), SpaceMath::Planet)
    end

    sig { returns(T::Boolean) }
    def launch?
      action == :launch
    end

    sig { returns(T::Boolean) }
    def land?
      action == :land
    end
  end
end
