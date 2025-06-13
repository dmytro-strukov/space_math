# typed: strict
# frozen_string_literal: true

module SpaceMath
  class Planet
    extend T::Sig

    sig { returns(Symbol) }
    attr_reader :name

    sig { returns(Float) }
    attr_reader :gravity

    sig { params(name: Symbol, gravity: Float).void }
    def initialize(name:, gravity:)
      @name = name
      @gravity = gravity
    end
  end
end
