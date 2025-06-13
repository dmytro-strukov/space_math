# SpaceMath - NASA Fuel Calculator

Ruby application for calculating fuel required for space missions between planets.

## Overview

This application calculates fuel requirements for launching from and landing on planets in our solar system. It implements NASA's fuel calculation formulas with recursive fuel-for-fuel calculations.

**Supported planets:**
- Earth (gravity: 9.807 m/s²)
- Moon (gravity: 1.62 m/s²)  
- Mars (gravity: 3.711 m/s²)

## Usage

### Command Line
```ruby
ruby lib/space_math.rb
```

### Interactive Console
```bash
./bin/console
```

### Programmatic Usage
```ruby
require_relative 'lib/space_math'

# Apollo 11 mission: Earth → Moon → Earth
mission = SpaceMath::Mission.new(steps: [
  SpaceMath::MissionStep.new(:launch, :earth),
  SpaceMath::MissionStep.new(:land, :moon),
  SpaceMath::MissionStep.new(:launch, :moon),
  SpaceMath::MissionStep.new(:land, :earth)
])

fuel_needed = SpaceMath.mission_calculate(28_801, mission)
puts "Fuel required: #{fuel_needed} kg"
```

## Type Checking with Sorbet

This project uses [Sorbet](https://sorbet.org/) for static type checking.

### Setup Sorbet (if needed)
```bash
# Generate RBI files for gems
bundle exec tapioca gems

# Generate RBI files for constants and missing definitions
bundle exec srb rbi todo
```

### Type Checking Commands
```bash
# Check types
bundle exec srb tc

# Type check with more verbose output
bundle exec srb tc --verbose
```

### Working with RBI Files
- **`sorbet/rbi/gems/`** - Auto-generated type definitions for gems (don't edit manually)
- **`sorbet/rbi/todo.rbi`** - Auto-generated definitions for missing constants
- **`sorbet/config`** - Sorbet configuration file

### Adding Type Annotations
Add type signatures to your Ruby code:
```ruby
# typed: strict
extend T::Sig

sig { params(mass: Integer, gravity: Float).returns(Integer) }
def calculate_fuel(mass, gravity)
  # implementation
end
```

### Updating RBI Files
When adding new gems or dependencies:
```bash
# Regenerate gem RBI files
bundle exec tapioca gems

# Update todo.rbi for new constants
bundle exec srb rbi todo
```

## Files in `bin/`

- **`bin/console`** - Interactive Ruby console with SpaceMath loaded
  - Provides IRB session with all SpaceMath classes available
  - Useful for testing and experimentation

## Example Missions

The application includes calculations for three reference missions:

1. **Apollo 11**: Earth → Moon → Earth (28,801 kg equipment)
2. **Mars Mission**: Earth → Mars → Earth (14,606 kg equipment)  
3. **Passenger Ship**: Earth → Moon → Mars → Earth (75,432 kg equipment)

## Fuel Calculation Formula

- **Launch**: `(mass × gravity × 0.042 - 33)` rounded down
- **Landing**: `(mass × gravity × 0.033 - 42)` rounded down

Additional fuel is calculated recursively until no more fuel is needed for the fuel itself.

## Development

### Code Quality Tools

This project uses several tools to maintain code quality:

- **RuboCop** - Ruby static code analyzer and formatter
- **Sorbet** - Static type checker for Ruby

### Running Tests Locally
```bash
# Run RuboCop (linting)
bundle exec rubocop

# Run Sorbet type checking
bundle exec srb tc
```

### Continuous Integration

GitHub Actions automatically runs the following checks on every push and pull request:

- Code style validation with RuboCop
- Type checking with Sorbet

All checks must pass before code can be merged. 