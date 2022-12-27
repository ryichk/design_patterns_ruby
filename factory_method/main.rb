# frozen_string_literal: true

# The Creator class declares the factory method that is supposed to return an object of a Product class.
class Creator
  def factory_method
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def some_operation
    product = factory_method

    "Creator: The same creator's code has just worked with #{product.operation}"
  end
end

# Concrete Creators override the factory method in order to change the resulting product's type.
class ConcreteCreator1 < Creator
  def factory_method
    ConcreteProduct1.new
  end
end

# ConcreteCreator2
class ConcreateCreator2 < Creator
  def factory_method
    ConcreteProduct2.new
  end
end

# The Product interface declares the operations that all concrete products must implement.
class Product
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Concrete Products provide various implementations of the Product interface.
class ConcreteProduct1 < Product
  def operation
    '{Result of the ConcreteProduct1}'
  end
end

# ConcreteProduct2
class ConcreteProduct2 < Product
  def operation
    '{Result of the ConcreteProduct2}'
  end
end

def client_code(creator)
  p "Client: I'm not aware of the creator's class, but it still works."
  p creator.some_operation
end

p 'App: Launched with the ConcreteCreator1.'
client_code(ConcreteCreator1.new)

p 'App: Launched with the ConcreteCreator2.'
client_code(ConcreateCreator2.new)
