# frozen_string_literal: true

# The Abstract Factory interface declare a set of methods that return different abstract products
class AbstractFactory
  def create_product_a
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def create_product_b
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Concrete Factories produce a family of products that belong to a single variant.
class ConcreteFactory1 < AbstractFactory
  def create_product_a
    ConcreteProductA1.new
  end

  def create_product_b
    ConcreteProductB1.new
  end
end

# Each Concrete Factory has a corresponding product variant.
class ConcreteFactory2 < AbstractFactory
  def create_product_a
    ConcreteProductA2.new
  end

  def create_product_b
    ConcreteProductB2.new
  end
end

# Each distinct product of a product family should have a base interface.
class AbstractProductA
  def useful_function_a
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Concrete Products are created by corresponding Concrete Factories.
class ConcreteProductA1 < AbstractProductA
  def useful_function_a
    'The result of the product A1.'
  end
end

class ConcreteProductA2 < AbstractProductA
  def useful_function_a
    'The result of the product A2.'
  end
end

# Here's the base interface of another product.
class AbstractProductB
  def useful_function_b
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def another_useful_function_b(_collaborator)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Concrete Products are created by corresponding Concrete Factories.
class ConcreteProductB1 < AbstractProductB
  def useful_function_b
    'The result of the product B1.'
  end

  def another_useful_function_b(collaborator)
    result = collaborator.useful_function_a
    "The result of the B1 collaborating with the (#{result})"
  end
end

class ConcreteProductB2 < AbstractProductB
  def useful_function_b
    'The result of the product B2.'
  end

  def another_useful_function_b(collaborator)
    result = collaborator.useful_function_a
    "The result of the B2 collaborating with the (#{result})"
  end
end

def client_code(factory)
  product_a = factory.create_product_a
  product_b = factory.create_product_b

  p product_b.useful_function_b.to_s
  p product_b.another_useful_function_b(product_a).to_s
end

p 'Client: Testing client code with the first factory type:'
client_code(ConcreteFactory1.new)

p 'Client: Testing the same client code with the second factory type:'
client_code(ConcreteFactory2.new)
