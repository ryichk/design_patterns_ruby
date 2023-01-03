# frozen_string_literal: true

# The Facade class provides a simple interface to the complex logic of one or several subsystems.
# The Facade delegates the client requests to the appropriate objects within the subsystem.
# The Facade is also responsible for managing their lifecycle.
class Facade
  # Depending on your application's needs, you can provide the Facade with existing subsystem objects or force the Facade to create them on its own.
  def initialize(subsystem1, subsystem2)
    @subsystem1 = subsystem1 || Subsystem1.new
    @subsystem2 = subsystem2 || Subsystem2.new
  end

  # The Facade's methods are convenient shortcuts to the sohisticated functionality of the subsystems.
  def operation
    results = []
    results.append('Facade initializes subsystems:')
    results.append(@subsystem1.operation1)
    results.append(@subsystem2.operation1)
    results.append('Facade orders subsystems to perform the action:')
    results.append(@subsystem1.operation_n)
    results.append(@subsystem2.operation_z)
    results.join("\n")
  end
end

# The Subsystem can accept requests either from the facade or client directly.
class Subsystem1
  # @return [String]
  def operation1
    'Subsystem1: Ready!'
  end

  # ...

  # @return [String]
  def operation_n
    'Subsystem1: Go!'
  end
end

# Some facades can work with multiple subsystems at the same time.
class Subsystem2
  # @return [String]
  def operation1
    'Subsystem2: Get ready!'
  end

  # ...

  # @return [String]
  def operation_z
    'Subsystem2: Fire!'
  end
end

# The client code works with complex subsystems through a simple interface provided by the Facade.
def client_code(facade)
  puts facade.operation
end

# The client code may have some of the subsystem's objects already created.
subsystem1 = Subsystem1.new
subsystem2 = Subsystem2.new
facade = Facade.new(subsystem1, subsystem2)
client_code(facade)
