# frozen_string_literal: true

require 'json'

# The Flyweight stores a common portion of the state (also called intrinsic state) that belongs to multiple real business entites.
class Flyweight
  # @param [String] shared_state
  def initialize(shared_state)
    @shared_state = shared_state
  end

  # @param [String] unique_state
  def operation(unique_state)
    s = @shared_state.to_json
    u = unique_state.to_json
    puts "Flyweight: Displaying shared (#{s}) and unique (#{u}) state."
  end
end

# The Flyweight Factory creates and manages the Flyweight objects.
class FlyweightFactory
  # @param [Hash] initial_flyweights
  def initialize(initial_flyweights)
    @flyweights = {}
    initial_flyweights.each do |state|
      @flyweights[get_key(state)] = Flyweight.new(state)
    end
  end

  # Returns a Flyweight's string hash for a given state.
  def get_key(state)
    state.sort.join('_')
  end

  # Returns an existing Flyweight with a given stateor creates a new one.
  def get_flyweight(shared_state)
    key = get_key(shared_state)

    if @flyweights.key?(key)
      puts 'FlyweightFactory: Reusing existing flyweight.'
    else
      puts "FlyweightFactory: Can't find a flyweight, creating new one."
      @flyweights[key] = Flyweight.new(shared_state)
    end

    @flyweights[key]
  end

  def list_flyweights
    puts "FlyweightFactory: I have #{@flyweights.size} flyweights:"
    puts @flyweights.keys.join("\n")
  end
end

# @param [FlyweightFactory] factory
# @param [String] plates
# @param [String] owner
# @param [String] brand
# @param [String] model
# @param [String] color
def add_car_to_police_database(factory, plates, owner, brand, model, color)
  puts "\n"
  puts "Client: Adding a car to database."
  flyweight = factory.get_flyweight([brand, model, color])
  # The client code either stores or calculates extrinsic state and passes it to the flyweight's methods.
  flyweight.operation([plates, owner])
end

# The client code usually creates a bunch of pre-populated flyweights in the initialization stage of the application.

factory = FlyweightFactory.new([
                                  %w(Chevrolet Camaro2018 pink),
                                  ['Mercedes Benz', 'C300', 'black'],
                                  ['Mercedes Benz', 'C500', 'red'],
                                  %w(BMW M5 red),
                                  %w(BMW X6 white)
                                ])

factory.list_flyweights

add_car_to_police_database(factory, 'CL234IR', 'James Doe', 'BMW', 'M5', 'red')
add_car_to_police_database(factory, 'CL234IR', 'James Doe', 'BMW', 'X1', 'blue')

puts "\n"

factory.list_flyweights
