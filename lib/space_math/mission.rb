# typed: strict
# frozen_string_literal: true

module SpaceMath
  class Mission
    extend T::Sig

    sig { returns(T::Array[MissionStep]) }
    attr_reader :steps

    sig { params(steps: T::Array[MissionStep]).void }
    def initialize(steps:)
      @steps = steps
    end

    sig { void }
    def validate!
      @steps.each_cons(2) do |current_step, next_step|
        next if current_step.nil? || next_step.nil?

        if current_step.launch? && !next_step.land?
          Kernel.raise ArgumentError, 'Launch must be followed by landing'
        elsif current_step.land? && next_step.launch? && next_step.planet_name != current_step.planet_name
          Kernel.raise ArgumentError, 'Launch must be from the same planet as previous landing'
        end
      end
    end
  end
end
