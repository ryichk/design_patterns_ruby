# frozen_string_literal: true

# The base Component interface defines operations that can be altered by decorators.
class Component
  # @return [String]
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Concrete Components provide default implementations of the operations.
class ConcreteComponent < Component
  # @return [String]
  def operation
    'ConcreteComponent'
  end
end

# The base Decorator class follows the same interface as the other components.
class Decorator < Component
  attr_accessor :component

  # @param [Component] component
  def initialize(component)
    @component = component
  end

  # The Decorator delegates all work to the wrapped component.
  def operation
    @component.operation
  end
end

# Concrete Decorators call the wrapped object and alter its result in some way.
class ConcreteDecoratorA < Decorator
  # Decorators may call parent implementation of the operation, instead of calling the wrapped object directly.
  def operation
    "ConcreteDecoratorA(#{@component.operation})"
  end
end

# Decorators can execute their behavior either before or after the call to a wrapped object.
class ConcreteDecoratorB < Decorator
  # @return [String]
  def operation
    "ConcreteDecoratorB(#{@component.operation})"
  end
end

# The client code works with all objects using the Component interface.
def client_code(component)
  puts "RESULT: #{component.operation}"
end

# This way the client code can support both simple components...
simple = ConcreteComponent.new
puts "Client: I've got a simple component:"
client_code(simple)
puts "\n"

# Note how decorators can wrap not only simple components but the other decorators as well.
decorate_a_component = ConcreteDecoratorA.new(simple)
decorate_b_component = ConcreteDecoratorB.new(decorate_a_component)
puts "Client: Now I've got a decorated component:"
client_code(decorate_b_component)
